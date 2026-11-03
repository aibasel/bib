#!/usr/bin/sed -f
#
# Sed script to replace BibTeX keys in .tex files
# Generated for 42 key changes
#
# Usage: sed -f this_script.sed your_file.tex > output.tex
#    or: sed -i.bak -f this_script.sed your_file.tex
#

# adaplanner -> sun-et-al-2023
s/\\cite\({[^}]*\)\badaplanner\b/\\cite\1sun-et-al-2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\badaplanner\b/\\cite[\1]\2sun-et-al-2023/g

# algo_of_thoughts -> sel-et-al-arxiv2023
s/\\cite\({[^}]*\)\balgo_of_thoughts\b/\\cite\1sel-et-al-arxiv2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\balgo_of_thoughts\b/\\cite[\1]\2sel-et-al-arxiv2023/g

# aravindan2025code -> aravindan-et-al-arxiv2025
s/\\cite\({[^}]*\)\baravindan2025code\b/\\cite\1aravindan-et-al-arxiv2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\baravindan2025code\b/\\cite[\1]\2aravindan-et-al-arxiv2025/g

# chencodet -> chen-et-al-
s/\\cite\({[^}]*\)\bchencodet\b/\\cite\1chen-et-al-/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bchencodet\b/\\cite[\1]\2chen-et-al-/g

# codeact -> wang-et-al-icml2024
s/\\cite\({[^}]*\)\bcodeact\b/\\cite\1wang-et-al-icml2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bcodeact\b/\\cite[\1]\2wang-et-al-icml2024/g

# codeaspolic -> liang-et-al-2023
s/\\cite\({[^}]*\)\bcodeaspolic\b/\\cite\1liang-et-al-2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bcodeaspolic\b/\\cite[\1]\2liang-et-al-2023/g

# colton2014countdown -> colton-2014
s/\\cite\({[^}]*\)\bcolton2014countdown\b/\\cite\1colton-2014/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bcolton2014countdown\b/\\cite[\1]\2colton-2014/g

# correa2025frontierllms -> correa-et-al-arxiv2025
s/\\cite\({[^}]*\)\bcorrea2025frontierllms\b/\\cite\1correa-et-al-arxiv2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bcorrea2025frontierllms\b/\\cite[\1]\2correa-et-al-arxiv2025/g

# deepseekai2025deepseekv3technicalreport -> deepseek-ai-et-al-arxiv2025
s/\\cite\({[^}]*\)\bdeepseekai2025deepseekv3technicalreport\b/\\cite\1deepseek-ai-et-al-arxiv2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bdeepseekai2025deepseekv3technicalreport\b/\\cite[\1]\2deepseek-ai-et-al-arxiv2025/g

# echchahedc25 -> echchahed-castro-2025
s/\\cite\({[^}]*\)\bechchahedc25\b/\\cite\1echchahed-castro-2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bechchahedc25\b/\\cite[\1]\2echchahed-castro-2025/g

# edelkamp-puk2000 -> edelkamp-2000
s/\\cite\({[^}]*\)\bedelkamp\-puk2000\b/\\cite\1edelkamp-2000/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bedelkamp\-puk2000\b/\\cite[\1]\2edelkamp-2000/g

# fu2022complexity -> fu-et-al-iclr
s/\\cite\({[^}]*\)\bfu2022complexity\b/\\cite\1fu-et-al-iclr/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bfu2022complexity\b/\\cite[\1]\2fu-et-al-iclr/g

# handaactionreasoningbench2024 -> handa-et-al-iclr2025
s/\\cite\({[^}]*\)\bhandaactionreasoningbench2024\b/\\cite\1handa-et-al-iclr2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bhandaactionreasoningbench2024\b/\\cite[\1]\2handa-et-al-iclr2025/g

# he-etal-2023-exploring -> he-et-al-acl-findings2023
s/\\cite\({[^}]*\)\bhe\-etal\-2023\-exploring\b/\\cite\1he-et-al-acl-findings2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bhe\-etal\-2023\-exploring\b/\\cite[\1]\2he-et-al-acl-findings2023/g

# hodel-bsc2024 -> hodel-2024
s/\\cite\({[^}]*\)\bhodel\-bsc2024\b/\\cite\1hodel-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bhodel\-bsc2024\b/\\cite[\1]\2hodel-2024/g

# hsiao2025proc -> hsiao-et-al-arxiv2025
s/\\cite\({[^}]*\)\bhsiao2025proc\b/\\cite\1hsiao-et-al-arxiv2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bhsiao2025proc\b/\\cite[\1]\2hsiao-et-al-arxiv2025/g

# koehler-hoffmann-puk2000 -> kohler-hoffmann-ecai2000puk
s/\\cite\({[^}]*\)\bkoehler\-hoffmann\-puk2000\b/\\cite\1kohler-hoffmann-ecai2000puk/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bkoehler\-hoffmann\-puk2000\b/\\cite[\1]\2kohler-hoffmann-ecai2000puk/g

# kokel-et-al-acphard -> kokel-et-al-arxiv2025
s/\\cite\({[^}]*\)\bkokel\-et\-al\-acphard\b/\\cite\1kokel-et-al-arxiv2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bkokel\-et\-al\-acphard\b/\\cite[\1]\2kokel-et-al-arxiv2025/g

# konidaris2018skills -> konidaris-et-al-2018
s/\\cite\({[^}]*\)\bkonidaris2018skills\b/\\cite\1konidaris-et-al-2018/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bkonidaris2018skills\b/\\cite[\1]\2konidaris-et-al-2018/g

# lats -> zhou-et-al-arxiv2023
s/\\cite\({[^}]*\)\blats\b/\\cite\1zhou-et-al-arxiv2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\blats\b/\\cite[\1]\2zhou-et-al-arxiv2023/g

# lecodechain -> le-et-al-2024
s/\\cite\({[^}]*\)\blecodechain\b/\\cite\1le-et-al-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\blecodechain\b/\\cite[\1]\2le-et-al-2024/g

# liu2018miniwobpp -> liu-et-al-iclr2018
s/\\cite\({[^}]*\)\bliu2018miniwobpp\b/\\cite\1liu-et-al-iclr2018/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bliu2018miniwobpp\b/\\cite[\1]\2liu-et-al-iclr2018/g

# llama3modelcard -> ai@meta-2024
s/\\cite\({[^}]*\)\bllama3modelcard\b/\\cite\1ai@meta-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bllama3modelcard\b/\\cite[\1]\2ai@meta-2024/g

# onplanningassess2023 -> valmeekam-et-al-2023
s/\\cite\({[^}]*\)\bonplanningassess2023\b/\\cite\1valmeekam-et-al-2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bonplanningassess2023\b/\\cite[\1]\2valmeekam-et-al-2023/g

# openai2024gpt4 -> openai-et-al-arxiv2024
s/\\cite\({[^}]*\)\bopenai2024gpt4\b/\\cite\1openai-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bopenai2024gpt4\b/\\cite[\1]\2openai-et-al-arxiv2024/g

# openai2024openai4ocard -> openai-et-al-arxiv2024
s/\\cite\({[^}]*\)\bopenai2024openai4ocard\b/\\cite\1openai-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bopenai2024openai4ocard\b/\\cite[\1]\2openai-et-al-arxiv2024/g

# openaiperformanceanalysis -> {openaidev.forum}-2024
s/\\cite\({[^}]*\)\bopenaiperformanceanalysis\b/\\cite\1{openaidev.forum}-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bopenaiperformanceanalysis\b/\\cite[\1]\2{openaidev.forum}-2024/g

# progprompt -> singh-et-al-2023
s/\\cite\({[^}]*\)\bprogprompt\b/\\cite\1singh-et-al-2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bprogprompt\b/\\cite[\1]\2singh-et-al-2023/g

# puri0jzdzd0cdtb21_codenet -> puri-et-al-nips2021
s/\\cite\({[^}]*\)\bpuri0jzdzd0cdtb21_codenet\b/\\cite\1puri-et-al-nips2021/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bpuri0jzdzd0cdtb21_codenet\b/\\cite[\1]\2puri-et-al-nips2021/g

# qwen2.5 -> team-2024
s/\\cite\({[^}]*\)\bqwen2\.5\b/\\cite\1team-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bqwen2\.5\b/\\cite[\1]\2team-2024/g

# scala-et-al-jair2020 -> scala-et-al-2020
s/\\cite\({[^}]*\)\bscala\-et\-al\-jair2020\b/\\cite\1scala-et-al-2020/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bscala\-et\-al\-jair2020\b/\\cite[\1]\2scala-et-al-2020/g

# sokoban1997 -> junghanns-schaeffer-ijcai1997
s/\\cite\({[^}]*\)\bsokoban1997\b/\\cite\1junghanns-schaeffer-ijcai1997/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bsokoban1997\b/\\cite[\1]\2junghanns-schaeffer-ijcai1997/g

# song2025coact -> song-et-al-arxiv2025
s/\\cite\({[^}]*\)\bsong2025coact\b/\\cite\1song-et-al-arxiv2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bsong2025coact\b/\\cite[\1]\2song-et-al-arxiv2025/g

# trivedikhmdlgsb24 -> trivedi-et-al-acl-findings2024
s/\\cite\({[^}]*\)\btrivedikhmdlgsb24\b/\\cite\1trivedi-et-al-acl-findings2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\btrivedikhmdlgsb24\b/\\cite[\1]\2trivedi-et-al-acl-findings2024/g

# vallati2025keps -> vallati-et-al-icaps2025
s/\\cite\({[^}]*\)\bvallati2025keps\b/\\cite\1vallati-et-al-icaps2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bvallati2025keps\b/\\cite[\1]\2vallati-et-al-icaps2025/g

# verma2025pddlinstruct -> verma-et-al-icaps2025
s/\\cite\({[^}]*\)\bverma2025pddlinstruct\b/\\cite\1verma-et-al-icaps2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bverma2025pddlinstruct\b/\\cite[\1]\2verma-et-al-icaps2025/g

# wangcy0l0j24 -> wang-et-al-icml2024
s/\\cite\({[^}]*\)\bwangcy0l0j24\b/\\cite\1wang-et-al-icml2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bwangcy0l0j24\b/\\cite[\1]\2wang-et-al-icml2024/g

# yaoreact -> yao-et-al-
s/\\cite\({[^}]*\)\byaoreact\b/\\cite\1yao-et-al-/g
s/\\cite\[{[^}]*\]\({[^}]*\)\byaoreact\b/\\cite[\1]\2yao-et-al-/g

# zhangcsdtg23 -> zhang-et-al-
s/\\cite\({[^}]*\)\bzhangcsdtg23\b/\\cite\1zhang-et-al-/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bzhangcsdtg23\b/\\cite[\1]\2zhang-et-al-/g

# zhanglllj23_selfedit -> zhang-et-al-2023
s/\\cite\({[^}]*\)\bzhanglllj23_selfedit\b/\\cite\1zhang-et-al-2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bzhanglllj23_selfedit\b/\\cite[\1]\2zhang-et-al-2023/g

# zhousolving -> zhou-et-al-2024
s/\\cite\({[^}]*\)\bzhousolving\b/\\cite\1zhou-et-al-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bzhousolving\b/\\cite[\1]\2zhou-et-al-2024/g

# zuo_planetarium -> zuo-et-al-arxiv2024
s/\\cite\({[^}]*\)\bzuo_planetarium\b/\\cite\1zuo-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bzuo_planetarium\b/\\cite[\1]\2zuo-et-al-arxiv2024/g

