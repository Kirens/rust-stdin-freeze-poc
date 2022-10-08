#! /bin/sh

echo "Working with $(cargo --version)"

rm -rf ./target
export STDIO_NULL=1
echo "> Explicitly set \`stdin\` to \`Stdio:null\`"
cargo run

rm -rf ./target
unset STDIO_NULL
echo
echo "> Don't specify \`stdin\`"
echo "> On 1.63 we expect this to freeze"
cargo run

