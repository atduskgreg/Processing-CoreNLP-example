import edu.stanford.nlp.ling.CoreLabel;
import edu.stanford.nlp.ling.HasWord;
import edu.stanford.nlp.process.CoreLabelTokenFactory;
import edu.stanford.nlp.process.DocumentPreprocessor;
import edu.stanford.nlp.process.PTBTokenizer;
import edu.stanford.nlp.util.CoreMap;

import java.util.Properties;
import java.util.List;


String msg;
void setup() {
  msg = join(loadStrings("message.txt"), "\n");

  StanfordCoreNLP pipeline;
  Properties props = new Properties();
  props.put("annotators", "tokenize, ssplit, pos, lemma, parse, ner, dcoref"); // , dcoref
  pipeline = new StanfordCoreNLP(props);

  Annotation document = new Annotation(msg);
  pipeline.annotate(document);

  List<CoreMap> sentences = document.get(CoreAnnotations.SentencesAnnotation.class);
  for (CoreMap sentence : sentences) {
    for (CoreLabel token : sentence.get(CoreAnnotations.TokensAnnotation.class)) {
      String word = token.get(CoreAnnotations.TextAnnotation.class);
      String ne = token.get(CoreAnnotations.NamedEntityTagAnnotation.class);

      if (!ne.equals("O")) {
        println(ne + " " + word);
      }
    }
  }
}

void draw() {
}

