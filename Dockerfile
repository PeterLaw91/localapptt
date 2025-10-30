# --- Build (Flutter) ---
FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app

# 👇 Add your ARG lines here — right after WORKDIR
ARG SUPABASE_URL
ARG SUPABASE_ANON_KEY

# Copy Flutter manifests and get dependencies first (cache-friendly)
COPY pubspec.* ./
RUN flutter config --enable-web && flutter pub get

# Copy the rest of your app
COPY . .

# 👇 Use the build args when compiling
RUN flutter build web --release \
  --no-tree-shake-icons \
  --dart-define=SUPABASE_URL=${SUPABASE_URL} \
  --dart-define=SUPABASE_ANON_KEY=${SUPABASE_ANON_KEY}

# --- Serve (NGINX) ---
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
