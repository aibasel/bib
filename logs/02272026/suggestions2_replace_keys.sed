#!/usr/bin/sed -f
#
# Sed script to replace BibTeX keys in .tex files
# Generated for 42 key changes
#
# Usage: sed -f this_script.sed your_file.tex > output.tex
#    or: sed -i.bak -f this_script.sed your_file.tex
#

# algo_of_thoughts -> sel-et-al-arxiv2023
s/\\cite\({[^}]*\)\balgo_of_thoughts\b/\\cite\1sel-et-al-arxiv2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\balgo_of_thoughts\b/\\cite[\1]\2sel-et-al-arxiv2023/g

# brown2020language -> brown-et-al-2020
s/\\cite\({[^}]*\)\bbrown2020language\b/\\cite\1brown-et-al-2020/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bbrown2020language\b/\\cite[\1]\2brown-et-al-2020/g

# caglar2024llms -> caglar-et-al-arxiv2024
s/\\cite\({[^}]*\)\bcaglar2024llms\b/\\cite\1caglar-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bcaglar2024llms\b/\\cite[\1]\2caglar-et-al-arxiv2024/g

# chencodet -> chen-et-al-
s/\\cite\({[^}]*\)\bchencodet\b/\\cite\1chen-et-al-/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bchencodet\b/\\cite[\1]\2chen-et-al-/g

# edelkamp-puk2000 -> edelkamp-2000
s/\\cite\({[^}]*\)\bedelkamp\-puk2000\b/\\cite\1edelkamp-2000/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bedelkamp\-puk2000\b/\\cite[\1]\2edelkamp-2000/g

# eval-harness -> gao-et-al-2024
s/\\cite\({[^}]*\)\beval\-harness\b/\\cite\1gao-et-al-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\beval\-harness\b/\\cite[\1]\2gao-et-al-2024/g

# fu2022complexity -> fu-et-al-2022
s/\\cite\({[^}]*\)\bfu2022complexity\b/\\cite\1fu-et-al-2022/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bfu2022complexity\b/\\cite[\1]\2fu-et-al-2022/g

# gou2024critic -> gou-et-al-2024
s/\\cite\({[^}]*\)\bgou2024critic\b/\\cite\1gou-et-al-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bgou2024critic\b/\\cite[\1]\2gou-et-al-2024/g

# gpt4o -> openai-2024
s/\\cite\({[^}]*\)\bgpt4o\b/\\cite\1openai-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bgpt4o\b/\\cite[\1]\2openai-2024/g

# granite2024granite -> graniteteam-2024
s/\\cite\({[^}]*\)\bgranite2024granite\b/\\cite\1graniteteam-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bgranite2024granite\b/\\cite[\1]\2graniteteam-2024/g

# granite3.1 -> graniteteam-GraniteTeam,IBM
s/\\cite\({[^}]*\)\bgranite3\.1\b/\\cite\1graniteteam-GraniteTeam,IBM/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bgranite3\.1\b/\\cite[\1]\2graniteteam-GraniteTeam,IBM/g

# granite_code -> mishra-et-al-arxiv2024
s/\\cite\({[^}]*\)\bgranite_code\b/\\cite\1mishra-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bgranite_code\b/\\cite[\1]\2mishra-et-al-arxiv2024/g

# handaactionreasoningbench2024 -> handa-et-al-2025
s/\\cite\({[^}]*\)\bhandaactionreasoningbench2024\b/\\cite\1handa-et-al-2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bhandaactionreasoningbench2024\b/\\cite[\1]\2handa-et-al-2025/g

# he-etal-2023-exploring -> he-et-al-2023
s/\\cite\({[^}]*\)\bhe\-etal\-2023\-exploring\b/\\cite\1he-et-al-2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bhe\-etal\-2023\-exploring\b/\\cite[\1]\2he-et-al-2023/g

# huang2024large -> huang-et-al-2024
s/\\cite\({[^}]*\)\bhuang2024large\b/\\cite\1huang-et-al-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bhuang2024large\b/\\cite[\1]\2huang-et-al-2024/g

# kambhampati2024position -> kambhampati-et-al-2024
s/\\cite\({[^}]*\)\bkambhampati2024position\b/\\cite\1kambhampati-et-al-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bkambhampati2024position\b/\\cite[\1]\2kambhampati-et-al-2024/g

# koehler-hoffmann-puk2000 -> kohler-hoffmann-ecai2000puk
s/\\cite\({[^}]*\)\bkoehler\-hoffmann\-puk2000\b/\\cite\1kohler-hoffmann-ecai2000puk/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bkoehler\-hoffmann\-puk2000\b/\\cite[\1]\2kohler-hoffmann-ecai2000puk/g

# kojima2022large -> kojima-et-al-2022
s/\\cite\({[^}]*\)\bkojima2022large\b/\\cite\1kojima-et-al-2022/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bkojima2022large\b/\\cite[\1]\2kojima-et-al-2022/g

# lats -> zhou-et-al-arxiv2023
s/\\cite\({[^}]*\)\blats\b/\\cite\1zhou-et-al-arxiv2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\blats\b/\\cite[\1]\2zhou-et-al-arxiv2023/g

# lecodechain -> le-et-al-2024
s/\\cite\({[^}]*\)\blecodechain\b/\\cite\1le-et-al-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\blecodechain\b/\\cite[\1]\2le-et-al-2024/g

# lin2025llmbasedagentssufferhallucinations -> lin-et-al-arxiv2025
s/\\cite\({[^}]*\)\blin2025llmbasedagentssufferhallucinations\b/\\cite\1lin-et-al-arxiv2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\blin2025llmbasedagentssufferhallucinations\b/\\cite[\1]\2lin-et-al-arxiv2025/g

# lipp24_mbpp -> li-et-al-2024
s/\\cite\({[^}]*\)\blipp24_mbpp\b/\\cite\1li-et-al-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\blipp24_mbpp\b/\\cite[\1]\2li-et-al-2024/g

# llama3modelcard -> ai@meta-2024
s/\\cite\({[^}]*\)\bllama3modelcard\b/\\cite\1ai@meta-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bllama3modelcard\b/\\cite[\1]\2ai@meta-2024/g

# mixtral8x22b -> mistralai-2024
s/\\cite\({[^}]*\)\bmixtral8x22b\b/\\cite\1mistralai-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bmixtral8x22b\b/\\cite[\1]\2mistralai-2024/g

# naturalplan -> zheng-et-al-arxiv2024
s/\\cite\({[^}]*\)\bnaturalplan\b/\\cite\1zheng-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bnaturalplan\b/\\cite[\1]\2zheng-et-al-arxiv2024/g

# onplanningassess2023 -> valmeekam-et-al-2023
s/\\cite\({[^}]*\)\bonplanningassess2023\b/\\cite\1valmeekam-et-al-2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bonplanningassess2023\b/\\cite[\1]\2valmeekam-et-al-2023/g

# openai2025gptoss120bgptoss20bmodel -> openai-et-al-arxiv2025
s/\\cite\({[^}]*\)\bopenai2025gptoss120bgptoss20bmodel\b/\\cite\1openai-et-al-arxiv2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bopenai2025gptoss120bgptoss20bmodel\b/\\cite[\1]\2openai-et-al-arxiv2025/g

# openaiperformanceanalysis -> {openaidev.forum}-2024
s/\\cite\({[^}]*\)\bopenaiperformanceanalysis\b/\\cite\1{openaidev.forum}-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bopenaiperformanceanalysis\b/\\cite[\1]\2{openaidev.forum}-2024/g

# prontoqa2023 -> hao-et-al-2023
s/\\cite\({[^}]*\)\bprontoqa2023\b/\\cite\1hao-et-al-2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bprontoqa2023\b/\\cite[\1]\2hao-et-al-2023/g

# puri0jzdzd0cdtb21_codenet -> puri-et-al-nips2021
s/\\cite\({[^}]*\)\bpuri0jzdzd0cdtb21_codenet\b/\\cite\1puri-et-al-nips2021/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bpuri0jzdzd0cdtb21_codenet\b/\\cite[\1]\2puri-et-al-nips2021/g

# raman2022planning -> raman-et-al-nips2022
s/\\cite\({[^}]*\)\braman2022planning\b/\\cite\1raman-et-al-nips2022/g
s/\\cite\[{[^}]*\]\({[^}]*\)\braman2022planning\b/\\cite[\1]\2raman-et-al-nips2022/g

# ramancirmtp24 -> raman-et-al-2024
s/\\cite\({[^}]*\)\bramancirmtp24\b/\\cite\1raman-et-al-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bramancirmtp24\b/\\cite[\1]\2raman-et-al-2024/g

# selfrefine -> madaan-et-al-2023
s/\\cite\({[^}]*\)\bselfrefine\b/\\cite\1madaan-et-al-2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bselfrefine\b/\\cite[\1]\2madaan-et-al-2023/g

# silver-et-al-nurips2022-wsfmdm -> silver-et-al-nips2022
s/\\cite\({[^}]*\)\bsilver\-et\-al\-nurips2022\-wsfmdm\b/\\cite\1silver-et-al-nips2022/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bsilver\-et\-al\-nurips2022\-wsfmdm\b/\\cite[\1]\2silver-et-al-nips2022/g

# sokoban1997 -> junghanns-schaeffer-1997
s/\\cite\({[^}]*\)\bsokoban1997\b/\\cite\1junghanns-schaeffer-1997/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bsokoban1997\b/\\cite[\1]\2junghanns-schaeffer-1997/g

# suzgunssgtcclcz23_bbh -> suzgun-et-al-2023
s/\\cite\({[^}]*\)\bsuzgunssgtcclcz23_bbh\b/\\cite\1suzgun-et-al-2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bsuzgunssgtcclcz23_bbh\b/\\cite[\1]\2suzgun-et-al-2023/g

# wei2022chain -> wei-et-al-2022
s/\\cite\({[^}]*\)\bwei2022chain\b/\\cite\1wei-et-al-2022/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bwei2022chain\b/\\cite[\1]\2wei-et-al-2022/g

# yao2023tree -> yao-et-al-2023
s/\\cite\({[^}]*\)\byao2023tree\b/\\cite\1yao-et-al-2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\byao2023tree\b/\\cite[\1]\2yao-et-al-2023/g

# yaoreact -> yao-et-al-
s/\\cite\({[^}]*\)\byaoreact\b/\\cite\1yao-et-al-/g
s/\\cite\[{[^}]*\]\({[^}]*\)\byaoreact\b/\\cite[\1]\2yao-et-al-/g

# zhanglllj23_selfedit -> zhang-et-al-2023
s/\\cite\({[^}]*\)\bzhanglllj23_selfedit\b/\\cite\1zhang-et-al-2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bzhanglllj23_selfedit\b/\\cite[\1]\2zhang-et-al-2023/g

# zhousolving -> zhou-et-al-2024
s/\\cite\({[^}]*\)\bzhousolving\b/\\cite\1zhou-et-al-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bzhousolving\b/\\cite[\1]\2zhou-et-al-2024/g

# zuo_planetarium -> zuo-et-al-arxiv2024
s/\\cite\({[^}]*\)\bzuo_planetarium\b/\\cite\1zuo-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bzuo_planetarium\b/\\cite[\1]\2zuo-et-al-arxiv2024/g

