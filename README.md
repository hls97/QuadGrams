# QuadGrams
With the problems with the decryption of the single byte xor cipher, a better way to determine the correct decrypted 
message is needed. The question to be answered is " is the string english". 
Expanding upon the character frequency leads to quadgrams. Quadgrams are sets of four characters, for example, in the phrase 
"hello there", the quadgrams are "hell", "ello", "llot", "loth" etc. Each quadgram occurs at a certain frequency across
literature and text. Applying machine learning, the computer creates its own standard of scoring english phrases with 
quadgrams.

Program Description:
    By taking in data from a large amount of text, first the text is split into quadgrams, and then the frequency is counted.
    The frequency is then converted into a score for each quadgram. Then inputted strings are given a score based on the
    quadgrams it contains.
    
Issues:
    With limited processing power and time, the amount of data that can be converted into the scoring system is restricted.
    To enhance this project, acquiring data from multiple sources, including newspapers, reviews, novels, and songs, is 
    needed to create a comphrehesive scoring system.
    
Harold Shen, UCSD
