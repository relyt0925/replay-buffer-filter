import json
import sys

from transformers import PreTrainedTokenizerFast

def main():
    if len(sys.argv) > 4:
        tokenizer_file_path = sys.argv[1]
        input_replay_buffer_path = sys.argv[2]
        output_file_path = sys.argv[3]
        max_seq_length = sys.argv[4]
    else:
        print(
            "tokenizer file arg 1, input replay buffer arg 2, output file arg 3, max sequence length arg 4"
        )
        return
    pretrained_tokenizer = PreTrainedTokenizerFast(
        tokenizer_file=tokenizer_file_path)
    with open(output_file_path, 'w') as output_file:
        with open(input_replay_buffer_path, 'r') as input_replay_buffer:
            for line in input_replay_buffer:
                tokens_in_line = pretrained_tokenizer.encode(line)
                if len(tokens_in_line) > int(max_seq_length):
                    continue
                output_file.write(line)


main()
