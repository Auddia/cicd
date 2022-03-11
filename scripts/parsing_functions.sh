(awk -F: '{
  print \
    "--ciphertext-file input_dir/"$2 " --plaintext-file output_dir/"$1 " --key "$1 \
}' input_dir=${{ inputs.input_dir }} output_dir=${{ inputs.output_dir }} input.txt