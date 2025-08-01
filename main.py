import json
import sys

from transformers import PreTrainedTokenizerFast

MAX_SEQ_LENGTH = 10 * 1024


def main():
    if len(sys.argv) > 3:
        tokenizer_file_path = sys.argv[1]
        input_replay_buffer_path = sys.argv[2]
        output_file_path = sys.argv[3]
    else:
        print(
            "tokenizer file arg 1, input replay buffer arg 2, output file arg 3"
        )
        return
    pretrained_tokenizer = PreTrainedTokenizerFast(
        tokenizer_file=tokenizer_file_path)
    with open(output_file_path, 'w') as output_file:
        with open(input_replay_buffer_path, 'r') as input_replay_buffer:
            for line in input_replay_buffer:
                tokens_in_line = pretrained_tokenizer.encode(line)
                if len(tokens_in_line) > MAX_SEQ_LENGTH:
                    continue
                output_file.write(line)

main()

