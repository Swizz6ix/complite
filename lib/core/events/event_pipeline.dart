abstract class EventPipeline<E, R> {
  Future<R> execute(E event);
}