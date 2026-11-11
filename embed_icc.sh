#!/bin/sh

# 引数が指定されているかチェック
if [ -z "$1" ]; then
    echo "Error: ICC profile path not specified." >&2
    echo "Usage: $0 <icc_profile_path>" >&2
    exit 1
fi

ICC="$1"

# カレントディレクトリの対象ファイルを検索してexiftoolで並列処理
find . -maxdepth 1 \( -name '*.jpg' -o -name '*.png' -o -name '*.webp' \) -print0 \
  | xargs -0 -P 8 -n 50 exiftool -overwrite_original "-ICC_Profile<=$ICC"

echo "Processing complete."
