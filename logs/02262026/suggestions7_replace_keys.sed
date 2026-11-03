#!/usr/bin/sed -f
#
# Sed script to replace BibTeX keys in .tex files
# Generated for 50 key changes
#
# Usage: sed -f this_script.sed your_file.tex > output.tex
#    or: sed -i.bak -f this_script.sed your_file.tex
#

# achiam2023gpt -> achiam-et-al-arxiv2023
s/\\cite\({[^}]*\)\bachiam2023gpt\b/\\cite\1achiam-et-al-arxiv2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bachiam2023gpt\b/\\cite[\1]\2achiam-et-al-arxiv2023/g

# agentbench -> liu-et-al-arxiv2023
s/\\cite\({[^}]*\)\bagentbench\b/\\cite\1liu-et-al-arxiv2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bagentbench\b/\\cite[\1]\2liu-et-al-arxiv2023/g

# agentboard -> ma-et-al-arxiv2024
s/\\cite\({[^}]*\)\bagentboard\b/\\cite\1ma-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bagentboard\b/\\cite[\1]\2ma-et-al-arxiv2024/g

# algo_of_thoughts -> sel-et-al-icml2024
s/\\cite\({[^}]*\)\balgo_of_thoughts\b/\\cite\1sel-et-al-icml2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\balgo_of_thoughts\b/\\cite[\1]\2sel-et-al-icml2024/g

# besta2024graph -> besta-et-al-aaai2024
s/\\cite\({[^}]*\)\bbesta2024graph\b/\\cite\1besta-et-al-aaai2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bbesta2024graph\b/\\cite[\1]\2besta-et-al-aaai2024/g

# brown2020language -> brown-et-al-neurips2020
s/\\cite\({[^}]*\)\bbrown2020language\b/\\cite\1brown-et-al-neurips2020/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bbrown2020language\b/\\cite[\1]\2brown-et-al-neurips2020/g

# caglar2024llms -> caglar-et-al-arxiv2024
s/\\cite\({[^}]*\)\bcaglar2024llms\b/\\cite\1caglar-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bcaglar2024llms\b/\\cite[\1]\2caglar-et-al-arxiv2024/g

# chen2024learning -> chen-et-al-2024
s/\\cite\({[^}]*\)\bchen2024learning\b/\\cite\1chen-et-al-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bchen2024learning\b/\\cite[\1]\2chen-et-al-2024/g

# chen2024teaching -> chen-et-al-iclr2024
s/\\cite\({[^}]*\)\bchen2024teaching\b/\\cite\1chen-et-al-iclr2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bchen2024teaching\b/\\cite[\1]\2chen-et-al-iclr2024/g

# chencodet -> chen-et-al-iclr2023
s/\\cite\({[^}]*\)\bchencodet\b/\\cite\1chen-et-al-iclr2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bchencodet\b/\\cite[\1]\2chen-et-al-iclr2023/g

# chenlsz24_selfdebug -> chen-et-al-iclr2024
s/\\cite\({[^}]*\)\bchenlsz24_selfdebug\b/\\cite\1chen-et-al-iclr2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bchenlsz24_selfdebug\b/\\cite[\1]\2chen-et-al-iclr2024/g

# deepseekv2 -> deepseek-ai-et-al-arxiv2024
s/\\cite\({[^}]*\)\bdeepseekv2\b/\\cite\1deepseek-ai-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bdeepseekv2\b/\\cite[\1]\2deepseek-ai-et-al-arxiv2024/g

# dubey2024llama3herdmodels -> dubey-et-al-arxiv2024
s/\\cite\({[^}]*\)\bdubey2024llama3herdmodels\b/\\cite\1dubey-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bdubey2024llama3herdmodels\b/\\cite[\1]\2dubey-et-al-arxiv2024/g

# edelkamp-puk2000 -> edelkamp-2000
s/\\cite\({[^}]*\)\bedelkamp\-puk2000\b/\\cite\1edelkamp-2000/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bedelkamp\-puk2000\b/\\cite[\1]\2edelkamp-2000/g

# fu2022complexity -> fu-et-al-iclr2022
s/\\cite\({[^}]*\)\bfu2022complexity\b/\\cite\1fu-et-al-iclr2022/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bfu2022complexity\b/\\cite[\1]\2fu-et-al-iclr2022/g

# gou2024critic -> gou-et-al-iclr2024
s/\\cite\({[^}]*\)\bgou2024critic\b/\\cite\1gou-et-al-iclr2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bgou2024critic\b/\\cite[\1]\2gou-et-al-iclr2024/g

# hu2024leveragingpd -> hu-et-al-arxiv2024
s/\\cite\({[^}]*\)\bhu2024leveragingpd\b/\\cite\1hu-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bhu2024leveragingpd\b/\\cite[\1]\2hu-et-al-arxiv2024/g

# huang2024large -> huang-et-al-iclr2024
s/\\cite\({[^}]*\)\bhuang2024large\b/\\cite\1huang-et-al-iclr2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bhuang2024large\b/\\cite[\1]\2huang-et-al-iclr2024/g

# humaneval -> chen-et-al-arxiv2021
s/\\cite\({[^}]*\)\bhumaneval\b/\\cite\1chen-et-al-arxiv2021/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bhumaneval\b/\\cite[\1]\2chen-et-al-arxiv2021/g

# jiang2023selfevolve -> jiang-et-al-arxiv2023
s/\\cite\({[^}]*\)\bjiang2023selfevolve\b/\\cite\1jiang-et-al-arxiv2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bjiang2023selfevolve\b/\\cite[\1]\2jiang-et-al-arxiv2023/g

# jiang2024mixtralexperts -> jiang-et-al-arxiv2024
s/\\cite\({[^}]*\)\bjiang2024mixtralexperts\b/\\cite\1jiang-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bjiang2024mixtralexperts\b/\\cite[\1]\2jiang-et-al-arxiv2024/g

# jimenezywyppn24 -> jimenez-et-al-iclr2024
s/\\cite\({[^}]*\)\bjimenezywyppn24\b/\\cite\1jimenez-et-al-iclr2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bjimenezywyppn24\b/\\cite[\1]\2jimenez-et-al-iclr2024/g

# koehler-hoffmann-puk2000 -> k{\"o}hler-hoffmann-ecai2000puk
s/\\cite\({[^}]*\)\bkoehler\-hoffmann\-puk2000\b/\\cite\1k{\"o}hler-hoffmann-ecai2000puk/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bkoehler\-hoffmann\-puk2000\b/\\cite[\1]\2k{\"o}hler-hoffmann-ecai2000puk/g

# kojima2022large -> kojima-et-al-neurips2022
s/\\cite\({[^}]*\)\bkojima2022large\b/\\cite\1kojima-et-al-neurips2022/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bkojima2022large\b/\\cite[\1]\2kojima-et-al-neurips2022/g

# lats -> zhou-et-al-icml2024
s/\\cite\({[^}]*\)\blats\b/\\cite\1zhou-et-al-icml2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\blats\b/\\cite[\1]\2zhou-et-al-icml2024/g

# lecodechain -> le-et-al-iclr2024
s/\\cite\({[^}]*\)\blecodechain\b/\\cite\1le-et-al-iclr2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\blecodechain\b/\\cite[\1]\2le-et-al-iclr2024/g

# lipp24_mbpp -> li-et-al-cav2024
s/\\cite\({[^}]*\)\blipp24_mbpp\b/\\cite\1li-et-al-cav2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\blipp24_mbpp\b/\\cite[\1]\2li-et-al-cav2024/g

# liu_llmp -> liu-et-al-arxiv2023
s/\\cite\({[^}]*\)\bliu_llmp\b/\\cite\1liu-et-al-arxiv2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bliu_llmp\b/\\cite[\1]\2liu-et-al-arxiv2023/g

# llama3modelcard -> ai@meta-2024
s/\\cite\({[^}]*\)\bllama3modelcard\b/\\cite\1ai@meta-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bllama3modelcard\b/\\cite[\1]\2ai@meta-2024/g

# llm-modulo -> kambhampati-et-al-arxiv2024
s/\\cite\({[^}]*\)\bllm\-modulo\b/\\cite\1kambhampati-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bllm\-modulo\b/\\cite[\1]\2kambhampati-et-al-arxiv2024/g

# muennighofflzzh24_octopack -> muennighoff-et-al-iclr2024
s/\\cite\({[^}]*\)\bmuennighofflzzh24_octopack\b/\\cite\1muennighoff-et-al-iclr2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bmuennighofflzzh24_octopack\b/\\cite[\1]\2muennighoff-et-al-iclr2024/g

# openai2024gpt4 -> openai-et-al-arxiv2024
s/\\cite\({[^}]*\)\bopenai2024gpt4\b/\\cite\1openai-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bopenai2024gpt4\b/\\cite[\1]\2openai-et-al-arxiv2024/g

# openai2024openai4ocard -> openai-et-al-arxiv2024
s/\\cite\({[^}]*\)\bopenai2024openai4ocard\b/\\cite\1openai-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bopenai2024openai4ocard\b/\\cite[\1]\2openai-et-al-arxiv2024/g

# openaiperformanceanalysis -> {openaidev.forum}-2024
s/\\cite\({[^}]*\)\bopenaiperformanceanalysis\b/\\cite\1{openaidev.forum}-2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bopenaiperformanceanalysis\b/\\cite[\1]\2{openaidev.forum}-2024/g

# pallagani_plangeneration -> pallagani-et-al-arxiv2023
s/\\cite\({[^}]*\)\bpallagani_plangeneration\b/\\cite\1pallagani-et-al-arxiv2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bpallagani_plangeneration\b/\\cite[\1]\2pallagani-et-al-arxiv2023/g

# puri0jzdzd0cdtb21_codenet -> puri-et-al-neurips2021db
s/\\cite\({[^}]*\)\bpuri0jzdzd0cdtb21_codenet\b/\\cite\1puri-et-al-neurips2021db/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bpuri0jzdzd0cdtb21_codenet\b/\\cite[\1]\2puri-et-al-neurips2021db/g

# raman2022planning -> raman-et-al-neurips2022wsfmdm
s/\\cite\({[^}]*\)\braman2022planning\b/\\cite\1raman-et-al-neurips2022wsfmdm/g
s/\\cite\[{[^}]*\]\({[^}]*\)\braman2022planning\b/\\cite[\1]\2raman-et-al-neurips2022wsfmdm/g

# reflexion_shinncgny23 -> shinn-et-al-neurips2023
s/\\cite\({[^}]*\)\breflexion_shinncgny23\b/\\cite\1shinn-et-al-neurips2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\breflexion_shinncgny23\b/\\cite[\1]\2shinn-et-al-neurips2023/g

# selfrefine -> madaan-et-al-neurips2023
s/\\cite\({[^}]*\)\bselfrefine\b/\\cite\1madaan-et-al-neurips2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bselfrefine\b/\\cite[\1]\2madaan-et-al-neurips2023/g

# silver-et-al-nurips2022-wsfmdm -> silver-et-al-neurips2022wsfmdm
s/\\cite\({[^}]*\)\bsilver\-et\-al\-nurips2022\-wsfmdm\b/\\cite\1silver-et-al-neurips2022wsfmdm/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bsilver\-et\-al\-nurips2022\-wsfmdm\b/\\cite[\1]\2silver-et-al-neurips2022wsfmdm/g

# sokoban1997 -> junghanns-schaeffer-ijcai1997
s/\\cite\({[^}]*\)\bsokoban1997\b/\\cite\1junghanns-schaeffer-ijcai1997/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bsokoban1997\b/\\cite[\1]\2junghanns-schaeffer-ijcai1997/g

# sos -> gandhi-et-al-arxiv2024
s/\\cite\({[^}]*\)\bsos\b/\\cite\1gandhi-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bsos\b/\\cite[\1]\2gandhi-et-al-arxiv2024/g

# stechly2024self -> stechly-et-al-arxiv2024
s/\\cite\({[^}]*\)\bstechly2024self\b/\\cite\1stechly-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bstechly2024self\b/\\cite[\1]\2stechly-et-al-arxiv2024/g

# xie_goal2pddl -> xie-et-al-arxiv2023
s/\\cite\({[^}]*\)\bxie_goal2pddl\b/\\cite\1xie-et-al-arxiv2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bxie_goal2pddl\b/\\cite[\1]\2xie-et-al-arxiv2023/g

# yang2024swe -> yang-et-al-arxiv2024
s/\\cite\({[^}]*\)\byang2024swe\b/\\cite\1yang-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\byang2024swe\b/\\cite[\1]\2yang-et-al-arxiv2024/g

# zhangcsdtg23 -> zhang-et-al-iclr2023
s/\\cite\({[^}]*\)\bzhangcsdtg23\b/\\cite\1zhang-et-al-iclr2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bzhangcsdtg23\b/\\cite[\1]\2zhang-et-al-iclr2023/g

# zhanglllj23_selfedit -> zhang-et-al-acl2023
s/\\cite\({[^}]*\)\bzhanglllj23_selfedit\b/\\cite\1zhang-et-al-acl2023/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bzhanglllj23_selfedit\b/\\cite[\1]\2zhang-et-al-acl2023/g

# zhong2024debuglikehuman -> zhong-et-al-arxiv2024
s/\\cite\({[^}]*\)\bzhong2024debuglikehuman\b/\\cite\1zhong-et-al-arxiv2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bzhong2024debuglikehuman\b/\\cite[\1]\2zhong-et-al-arxiv2024/g

# zhousolving -> zhou-et-al-iclr2024
s/\\cite\({[^}]*\)\bzhousolving\b/\\cite\1zhou-et-al-iclr2024/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bzhousolving\b/\\cite[\1]\2zhou-et-al-iclr2024/g

# zuo_planetarium -> zuo-et-al-naacl2025
s/\\cite\({[^}]*\)\bzuo_planetarium\b/\\cite\1zuo-et-al-naacl2025/g
s/\\cite\[{[^}]*\]\({[^}]*\)\bzuo_planetarium\b/\\cite[\1]\2zuo-et-al-naacl2025/g

