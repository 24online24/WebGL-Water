# File: build.ps1

# Change directory to the script's directory
Set-Location $PSScriptRoot

# If RELEASE environment variable is not set
if (-not $env:RELEASE) {
  $env:RUST_BACKTRACE = 1
  cargo build --target wasm32-unknown-unknown
  wasm-bindgen .\target\wasm32-unknown-unknown\debug\webgl_water.wasm --out-dir . --no-typescript --no-modules
}
else {
  cargo build --target wasm32-unknown-unknown --release
  wasm-bindgen .\target\wasm32-unknown-unknown\release\webgl_water.wasm --out-dir . --no-typescript --no-modules
  wasm-opt -O3 -o optimized.wasm webgl_water_bg.wasm
  Move-Item optimized.wasm webgl_water_bg.wasm
}