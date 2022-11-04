from pudb.var_view import default_stringifier


def get_fullname(obj):
    return f"{type(obj).__module__}.{type(obj).__qualname__}"


def pudb_stringifier(obj):
    # TODO Use registry pattern
    if get_fullname(obj) == "torch.Tensor":
        threshold = 6  # Empirical magic number

        if obj.numel() <= threshold:
            return f"<torch.Tensor> Value {obj.tolist()}"

        return f"<torch.Tensor> Shape {list(obj.shape)}"

    return default_stringifier(obj)
