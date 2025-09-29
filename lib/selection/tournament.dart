import 'dart:math';

import 'package:dart_genetic_algorithm/individual.dart';

import 'selection_abstract.dart';

// É uma boa prática ter uma única instância de Random se for usada em múltiplos lugares,
// mas para manter a classe autocontida, podemos instanciá-la aqui.
final _random = Random();

/// Implementa a estratégia de Seleção por Torneio.
///
/// Esta técnica seleciona um pai escolhendo um número de indivíduos
/// aleatoriamente da população (o 'tamanho do torneio') e, em seguida,
/// escolhendo o indivíduo com o melhor fitness desse pequeno grupo.
class Tournament<T> implements SelectionAbstract<T> {
  final int tournamentSize;

  /// Cria uma instância da Seleção por Torneio.
  ///
  /// [tournamentSize] determina quantos indivíduos competirão em cada
  /// torneio. Um valor comum e um bom ponto de partida é 3.
  Tournament({this.tournamentSize = 3});

  @override
  Individual<T> selectParent(List<Individual<T>> population) {
    // Garante que a população não esteja vazia.
    if (population.isEmpty) {
      throw ArgumentError('A população não pode estar vazia.');
    }

    Individual<T>? winner;

    // Realiza o torneio.
    for (int i = 0; i < tournamentSize; i++) {
      // Seleciona um competidor aleatório da população.
      final randomIndex = _random.nextInt(population.length);
      final competitor = population[randomIndex];

      // Se este é o primeiro competidor ou se ele é melhor que o vencedor atual,
      // ele se torna o novo vencedor.
      if (winner == null || competitor.fitness > winner.fitness) {
        winner = competitor;
      }
    }
    
    // Retorna o vencedor do torneio. O operador '!' garante que o valor não é nulo.
    return winner!;
  }

    /// Seleciona um número [count] de indivíduos da [population] para serem pais.
  ///
  /// Para cada um dos [count] indivíduos a serem selecionados, um torneio
  /// separado é realizado.
  ///
  /// Retorna uma lista com os indivíduos vencedores.
  List<Individual<T>> select(List<Individual<T>> population, int count) {
    // Validações de entrada
    if (population.isEmpty) {
      throw ArgumentError('A população não pode estar vazia.');
    }
    if (count <= 0) {
      throw ArgumentError('O número de indivíduos a selecionar deve ser positivo.');
    }

    final List<Individual<T>> selected = [];

    // Repete o processo de seleção 'count' vezes para obter a quantidade
    // desejada de pais.
    for (int i = 0; i < count; i++) {
      // --- Lógica do Torneio Individual ---

      // 1. Seleciona os competidores para este torneio.
      // Esta abordagem (sem reposição para o torneio) é mais próxima do DEAP.
      final List<Individual<T>> contestants = [];
      for (int j = 0; j < tournamentSize; j++) {
        final randomIndex = _random.nextInt(population.length);
        contestants.add(population[randomIndex]);
      }

      // 2. Encontra o melhor competidor (vencedor do torneio).
      // Usar 'reduce' é uma forma funcional e elegante de encontrar o melhor.
      final winner = contestants.reduce(
        (currentWinner, competitor) =>
            competitor.fitness > currentWinner.fitness ? competitor : currentWinner,
      );

      selected.add(winner);
    }

    return selected;
  }
}