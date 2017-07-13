defmodule Joshua.Progress do
  use Joshua.Web, :model

  defstruct [:name, :count, :required, :achieved]

  @type t :: %__MODULE__{
    name: String.t(),
    count: integer,
    required: integer,
    achieved: boolean
  }

end
