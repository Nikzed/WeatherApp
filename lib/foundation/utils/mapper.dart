abstract class Mapper<T1, T2> {
  T2 map(T1 value);

  T1 reverseMap(T2 value);
}
