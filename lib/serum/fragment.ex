defmodule Serum.Fragment do
  @moduledoc """
  Defines a struct representing a page fragment.

  ## Fields

  * `file`: Source path. This can be `nil` if created internally.
  * `output`: Destination path
  * `metadata`: A map holding extra information about the fragment
  * `data`: Contents of the page fragment
  """

  @type t :: %__MODULE__{
          file: binary() | nil,
          output: binary(),
          metadata: map(),
          data: binary()
        }

  defstruct [:file, :output, :metadata, :data]

  @doc "Creates a new `Fragment` struct."
  @spec new(binary() | nil, binary(), map(), binary()) :: t()
  def new(file, output, metadata, data) do
    %__MODULE__{
      file: file,
      output: output,
      metadata: metadata,
      data: data
    }
  end
end
