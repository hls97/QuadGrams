(* ::Package:: *)

(* ::Section:: *)
(*Scoring English using Quad Grams*)


(* ::Subsubsubsection:: *)
(*How can we make a computer recognize how "English"  a piece of text is?*)


(* ::Subsection::Closed:: *)
(*Initialization*)


score=1; scoreList="";
pride=StringTake[ExampleData[{"Text","PrideAndPrejudice"}],15000];
(*Import["C:\\Users\\Harold\\Desktop\\english_quadgrams.txt","List"]*)


(* ::Subsection:: *)
(*Computation of Quadgram List and Scoring *)


(* ::Subsubsubsection:: *)
(*To begin with, we must create our own scoring for how English a piece of text is by using data of English text. Due to the limitations of the processing power of my computer, we will be using only the first 15000 characters of Pride and Prejudice as our data set. Of course, a legetimate scoring would require a much larger data set to cover all possibilites, including newer english, colloquial english, etc. To start, we create a function for making a text into a string of english letters without any special characters or spaces or numbers or capitals etc.*)


(* ::Input:: *)
(*stringCleaner[mesg_]:=ToLowerCase@StringJoin[StringSplit[mesg,{" ",",",".","!","?",":","'","\"",";","-","_","(",")","*","1","2","3","4","5","6","7","8","9","0"}]];*)
(**)
(*cleanPride=stringCleaner[pride]*)
(**)


(* ::Subsubsubsection:: *)
(*The next step is to extract every quadgram that exists in the string we have created. An example of the quadgrams of "chapter" is "chap", "hapt", "apte", "pter". Quadgrams however extend to the following words as well, since what we have is not individual words, but a long string of characters.*)


(* ::Input:: *)
(*getQuadGram[mesg_]:=StringTake[stringCleaner[mesg],Table[{i,i+3},{i,StringLength[stringCleaner[mesg]]-3}]];*)
(*prideQuadGrams=getQuadGram[cleanPride]*)


(* ::Subsubsubsection:: *)
(*Now that we have all the quadgrams in those first 15000 character of Pride and Prejudice, we must create a score that each quadgram is "English" like. Our score this time will be the log base 10 of the number of times the quadgram appears over the total number of quadgrams. For example:  Subscript[log, 10][count(chap)/count(quadgrams)]*)


(* ::Input:: *)
(*prideQuadGramsFreq=Reverse[Sort[Tally[getQuadGram[cleanPride]],#1[[2]]<#2[[2]]&]]*)


(* ::Input:: *)
(*probCalc[freqList_]:=N[Log[10,freqList[[2]]/Length[prideQuadGrams]]]*)
(*probCalc[prideQuadGramsFreq[[1]]]*)


(* ::Input:: *)
(*logProbCalc[freqList_]:=Map[probCalc,freqList];*)


(* ::Input:: *)
(* prideLogProb=logProbCalc[prideQuadGramsFreq]*)


(* ::Subsubsubsection:: *)
(*Now to make it a list of rules using Dispatch*)


(* ::Input:: *)
(*ruleCreator[freqList_,logProb_]:=Dispatch[Thread[Flatten[Drop[#,{2}]&/@freqList]->logProb]]*)
(*prideProb=ruleCreator[prideQuadGramsFreq,prideLogProb]*)


(* ::Subsubsubsection:: *)
(*Our final score for a piece of text will be using the formula log[AB]=log[A]+log[B]. The score of a length of text will be the sum of the log probability of each quadgram divided by the length of the text. The higher the score, the more English it is. Feel free to try out some strings.*)


(* ::Input:: *)
(**)
(*scoreEnglishProb[text_]:=(score=0;scoreList="";scoreList=ReplaceAll[getQuadGram[text],prideProb];For[i=1,i<Length[scoreList],i++,If[MatchQ[scoreList[[i]],_String],score=score+(-8.0),score=score+scoreList[[i]]]];score/Length[scoreList])*)
(*scoreEnglishProb["It will be no use to us, if twenty such should come, since you will not visit them"]*)
(*scoreEnglishProb["ITWILLBENOUSETOUSIFTWENTYSUCHSHOULDCOMESINCEYOUWILLNOTVISITTHEM"]*)
(*scoreEnglishProb["Hello there, friend"]*)
(*scoreEnglishProb["Hola Amigo Como estas"]*)


(* ::Subsubsubsection:: *)
(*As described before, our sample data size is severely compromised due to the limitations in computational power of my laptop. As such, many quadgrams that may be found in colloquial language or, in all honesty, any other text besides the first 10000+ characters of Pride and Prejudice, will not have a probability associated with it in our list of rules. As such, a common phrase such as "hello friend" does not even appear in our data, and receives a low score.*)
