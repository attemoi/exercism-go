package strain

// Implement the "Keep" and "Discard" function in this file.

// You will need typed parameters (aka "Generics") to solve this exercise.
// They are not part of the Exercism syllabus yet but you can learn about
// them here: https://go.dev/tour/generics/1

func Keep[T any](input []T, predicate func(T) bool) []T {
	output := []T{}
	for _, v := range input {
		if predicate(v) {
			output = append(output, v)
		}
	}
	return output
}

func Discard[T any](input []T, predicate func(T) bool) []T {
	return Keep(input, func(item T) bool { return !predicate(item) })
}
