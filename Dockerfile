# Étape de build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copier tous les fichiers projet/solution
COPY src/ .

# Restaurer les dépendances
RUN dotnet restore 

# Compiler l'application
RUN dotnet build -c Release -o /app/build

# Étape d'exécution
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app/build .
ENTRYPOINT ["dotnet", "GC.WebReact.dll"]
