defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  @spec to_rna([char], [char]) :: [char]
  def to_rna(dna, result \\ [])

  def to_rna([], result) do
    result
  end

  def to_rna([dna_head | dna_tail], result) do
    to_rna(dna_tail, result ++ [transcribe_a_single_dna_nucleotide_to_rna(dna_head)])
  end

  @spec transcribe_a_single_dna_nucleotide_to_rna(char) :: char
  defp transcribe_a_single_dna_nucleotide_to_rna(dna_nucleotide) do
    case dna_nucleotide do
      ?G -> ?C
      ?C -> ?G
      ?T -> ?A
      ?A -> ?U
    end
  end
end
