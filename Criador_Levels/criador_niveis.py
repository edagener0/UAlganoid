import random
import os
import re

ROWS = 15
COLS = 13

levels = [file for file in os.listdir("levels") if file.startswith("level_") and file.endswith(".lvl")]
def create_level():
    if not levels: 
        level_number = 0
    else: 
        level_number = max([int(re.findall(r"\d+", level)[0]) for level in levels]) + 1

    level_name = f"levels/level_{level_number}.lvl"
    level = ""

    for _ in range(ROWS - 1):
        for _ in range(COLS - 1):
            level += str(random.randint(0, 9)) + ","

        level += str(random.randint(0, 9))

        level += "\n"
    
    for _ in range(COLS - 1):
        level += str(random.randint(0, 9)) + ","

    level += str(random.randint(0, 9))

    with open(level_name, 'w') as file:
        file.write(level)
    levels.append(level_name)

def main():
    levels_to_generate = int(input("Insere o número de níveis que pretendes gerar: "))
    for _ in range(levels_to_generate):
        create_level()

if __name__ == "__main__":
    main()