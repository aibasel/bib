#!/usr/bin/sed -f
#
# Sed script to replace BibTeX keys in .tex files
# Generated for 5 key changes
#
# Usage: sed -f this_script.sed your_file.tex > output.tex
#    or: sed -i.bak -f this_script.sed your_file.tex
#

# butt2024benchagents -> butt-et-al-arxiv2024
s/\\cite\({[^}]*\)\bbutt2024benchagents\b/\\cite\1butt-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bbutt2024benchagents\b/\\cite[\1]\2butt-et-al-arxiv2024/g

# gpt4o -> openai-2024
s/\\cite\({[^}]*\)\bgpt4o\b/\\cite\1openai-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bgpt4o\b/\\cite[\1]\2openai-2024/g

# simonis2005sudoku -> simonis-2005
s/\\cite\({[^}]*\)\bsimonis2005sudoku\b/\\cite\1simonis-2005/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bsimonis2005sudoku\b/\\cite[\1]\2simonis-2005/g

# tantaakoun-et-al-arxiv2025 -> tantakoun-et-al-arxiv2025
s/\\cite\({[^}]*\)\btantaakoun\-et\-al\-arxiv2025\b/\\cite\1tantakoun-et-al-arxiv2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\btantaakoun\-et\-al\-arxiv2025\b/\\cite[\1]\2tantakoun-et-al-arxiv2025/g

# text2world -> hu-et-al-arxiv2025
s/\\cite\({[^}]*\)\btext2world\b/\\cite\1hu-et-al-arxiv2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\btext2world\b/\\cite[\1]\2hu-et-al-arxiv2025/g

