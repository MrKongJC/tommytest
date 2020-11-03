#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim
WORKDIR /app
EXPOSE 80
COPY ["Tommy.Demo/Tommy.Demo.csproj", "Tommy.Demo/"]
RUN dotnet restore "Tommy.Demo/Tommy.Demo.csproj"
COPY . .
WORKDIR "/src/Tommy.Demo"
RUN dotnet build "Tommy.Demo.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Tommy.Demo.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Tommy.Demo.dll"]