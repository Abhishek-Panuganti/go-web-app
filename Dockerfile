# FROM golang:1.21 AS base is commonly used to set up a Go development environment in a Docker image.
From golang:1.21 as base

# create work directory in that below commands will be executed
WORKDIR /app              

# Copy all the dependencies require for the build
COPY go.mod ./

# download it i mean install it hear
RUN go mod download

# copy all the source code
COPY . .

# run the build command
RUN go build -o main .

# Final stage -Distroless image which is light weight reduces file size
FROM gcr.io/distroless/base

# copy the binary of the code into the image
COPY --from=base /app/main .

# copy the static file into the distroless image 
COPY --from=base /app/static ./static

# expose the port
EXPOSE 8080

# default commad
CMD ["./main"]

