import '../model/question.dart';
import '../model/questions.dart';

class QuestionProvider {
  // Instância única (singleton) de QuestionProvider
  static final QuestionProvider helper = QuestionProvider._createInstance();

  // Lista de perguntas e pontos de quebra para dividir o formulário em seções
  final Questions questions;

  // Construtor privado para inicializar a instância com dados hardcoded
  QuestionProvider._createInstance()
      : questions = Questions(
          questionList: [
            // Perguntas iniciais
            Question(
              titulo: "Primeira",
              subTitulo: "",
              alternatives: ["a", "b", "c", "d"],
              type: QuestionType.multiple,
            ),
            Question(
              titulo: "Segunda",
              subTitulo: "Tenho um subtítulo",
              alternatives: ["a", "b", "c", "d"],
              type: QuestionType.singleShort,
            ),
            Question(
              titulo: "Terceira",
              subTitulo: "Tenho um subtítulo",
              alternatives: [],
              type: QuestionType.text,
            ),

            // Novas perguntas solicitadas
            Question(
              titulo: "Euler, em que ano você nasceu?",
              subTitulo: "",
              alternatives: [],
              type: QuestionType.text,
            ),
            Question(
              titulo: "Euler, qual a sua altura em centímetros?",
              subTitulo: "",
              alternatives: [],
              type: QuestionType.text,
            ),
            Question(
              titulo: "Euler, você gosta de mim?",
              subTitulo: "",
              alternatives: ["Sim", "Não"],
              type: QuestionType.singleShort,
            ),
            Question(
              titulo: "Euler, você já viajou para quais cidades?",
              subTitulo: "",
              alternatives: ["Limeira", "Campinas", "Americana", "Valinhos"],
              type: QuestionType.multiple,
            ),
          ],
          breakpoints: [1, 2, 4, 5, 8], // Ajuste de breakpoints conforme o novo número de perguntas
        );
}
