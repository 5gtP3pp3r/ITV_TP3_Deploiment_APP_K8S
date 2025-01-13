# Étape de build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copier les fichiers de projet pour maximiser l'utilisation du cache
COPY GC.WebReact/GC.WebReact.csproj GC.WebReact/
RUN dotnet restore GC.WebReact/GC.WebReact.csproj

# Copier le reste des fichiers de l'application et publier
COPY GC.WebReact/ GC.WebReact/
WORKDIR /src/GC.WebReact
RUN dotnet publish -c Release -o /app

# Étape d'exécution
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=build /app .
ENTRYPOINT ["dotnet", "GC.WebReact.dll"]
