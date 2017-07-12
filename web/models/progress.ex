defmodule Joshua.Progress do

  defstruct [:name, :count, :required, :achieved]

  @type t :: %__MODULE__{
    name: String.t(),
    count: integer,
    required: integer,
    achieved: boolean
  }

end
