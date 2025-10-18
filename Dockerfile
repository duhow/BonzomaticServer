##############################################################################
# ALL-IN-ONE COMPILATION OF BONZOMATIC SERVER AND PRODUCTION OF AN EMPTY
# ALPINE LINUX IMAGE WITH THE COMPILED BINARY IN /app
#
# Build from project root with:
# `docker build --force-rm --no-cache --rm -t BonzomaticServer .`
##############################################################################

##############################################################################
# Compile the server
FROM golang:alpine AS builder

# Work in the app folder
WORKDIR /app

# Copy the source code and assets files
COPY main.go go.mod go.sum ./

# Build the executable
RUN go build -o BonzomaticServer

##############################################################################
# Final stage (wrap the compiled server in a linux alpine image ready for run)
FROM alpine:3.22

# Work in the app folder
WORKDIR /app

# Copy the executable built during the previous stage
COPY --from=builder /app/BonzomaticServer .

EXPOSE 9000

# Launch the server
CMD ["/app/BonzomaticServer"]
