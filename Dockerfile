# Tahap 1: Build
FROM node:16-slim AS builder
WORKDIR /usr/app/
COPY package.json yarn.lock ./
RUN yarn install
COPY ./ ./
RUN yarn build

# Tahap 2: Jalankan aplikasi di image ringan
FROM node:16-alpine
WORKDIR /usr/app/
RUN yarn global add serve
COPY --from=builder /usr/app/build ./build
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]
