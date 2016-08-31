FROM microsoft/dotnet:latest

MAINTAINER Stefan Prodan

# Set environment variables
ENV ASPNETCORE_URLS="http://*:5050"
ENV ASPNETCORE_ENVIRONMENT="Staging"

# Copy files to app directory
COPY /src/Docker.DotNet /app/src/Docker.DotNet
COPY /src/DockerDash /app/src/DockerDash

# add myget aspnetmaster
COPY NuGet.Config /app/src/DockerDash/NuGet.Config

# Restore Docker.DotNet packages
WORKDIR /app/src/Docker.DotNet
RUN ["dotnet", "restore"]

# Set working directory
WORKDIR /app/src/DockerDash

# Restore DockerDash packages
RUN ["dotnet", "restore"]

# Build DockerDash
RUN ["dotnet", "build"]

# Open port
EXPOSE 5050/tcp

# Run
ENTRYPOINT ["dotnet", "run"]