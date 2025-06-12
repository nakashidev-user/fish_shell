#!/bin/bash

# 検索クエリを引数から取得する
query="$*"

# 検索結果ページをGoogleから取得する
search_results=$(curl -s "https://www.google.com/search?q=${query// /+}")
# タイトルとURLを抽出して表示する
titles=$(echo "$search_results" | grep -oE '<h3 class="[^"]+"><a[^>]+>.+?</a></h3>' | sed -E 's/<[^>]+>//g')
urls=$(echo "$search_results" | grep -oE '<div class="[^"]+"><a href="/url\?q=([^&]+)' | sed -E 's/.*href="\/url\?q=([^&]+).*/\1/')

# タイトルとURLを一致させて表示する
paste -d"\t" <(echo "$titles") <(echo "$urls")
