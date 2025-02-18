/// Sorts a list of integers using the Bubble Sort algorithm.
///
/// Bubble Sort repeatedly compares adjacent elements and swaps them if they are in the wrong order.
/// It is a simple but inefficient algorithm for large lists.
///
/// Args:
///   arr: The list of integers to sort.
///
/// Returns:
///   A new list containing the sorted integers.
List<int> bubbleSort(List<int> arr) {
  int n = arr.length;
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        // Swap arr[j] and arr[j+1]
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
  return arr;
}

/// Sorts a list of integers using the Merge Sort algorithm.
///
/// Merge Sort is a divide-and-conquer algorithm that recursively divides the list into smaller sublists,
/// sorts them, and then merges them back together. It is a more efficient algorithm than Bubble Sort
/// for larger lists.
///
/// Args:
///   arr: The list of integers to sort.
///
/// Returns:
///   A new list containing the sorted integers.
List<int> mergeSort(List<int> arr) {
  if (arr.length <= 1) {
    return arr;
  }

  int middle = arr.length ~/ 2;
  List<int> left = arr.sublist(0, middle);
  List<int> right = arr.sublist(middle);

  left = mergeSort(left);
  right = mergeSort(right);

  return _merge(left, right);
}

/// Merges two sorted lists into a single sorted list.
///
/// This is a helper function used by Merge Sort.
///
/// Args:
///   left: The first sorted list.
///   right: The second sorted list.
///
/// Returns:
///   A new list containing all elements from both input lists, sorted.
List<int> _merge(List<int> left, List<int> right) {
  List<int> result = [];
  int i = 0;
  int j = 0;

  while (i < left.length && j < right.length) {
    if (left[i] <= right[j]) {
      result.add(left[i]);
      i++;
    } else {
      result.add(right[j]);
      j++;
    }
  }

  // Add any remaining elements from left or right
  result.addAll(left.sublist(i));
  result.addAll(right.sublist(j));

  return result;
}

/// Compares the performance of Bubble Sort and Merge Sort on a given list.
///
/// This function measures the execution time of each sorting algorithm using the Stopwatch class
/// and prints the results to the console.
///
/// Args:
///   arr: The list of integers to use for the comparison.
void compareSortingAlgorithms(List<int> arr) {
  List<int> arrCopy1 = List.from(arr); // Create copies to avoid modifying original
  List<int> arrCopy2 = List.from(arr);

  Stopwatch stopwatch = Stopwatch();

  stopwatch.start();
  bubbleSort(arrCopy1);
  stopwatch.stop();
  print('Bubble Sort: ${stopwatch.elapsedMicroseconds} microseconds');

  stopwatch.reset();
  stopwatch.start();
  mergeSort(arrCopy2);
  stopwatch.stop();
  print('Merge Sort: ${stopwatch.elapsedMicroseconds} microseconds');
}

void main() {
  List<int> unsortedList = [64, 34, 25, 12, 22, 11, 90, 1, 5, 2, 8, 3, 9, 4, 7, 6];
  print("Unsorted List: $unsortedList");

  List<int> sortedBubble = bubbleSort(List.from(unsortedList)); // Sort using bubble sort
  print("Sorted (Bubble Sort): $sortedBubble");

  List<int> sortedMerge = mergeSort(List.from(unsortedList)); // Sort using merge sort
  print("Sorted (Merge Sort): $sortedMerge");

  compareSortingAlgorithms(unsortedList);
}
