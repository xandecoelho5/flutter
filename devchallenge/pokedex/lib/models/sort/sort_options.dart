enum SortOptions {
  smallestNumber('Smallest number first'),
  highestNumber('Highest number first'),
  aZ('A-Z'),
  zA('Z-A');

  const SortOptions(this.label);

  final String label;
}
