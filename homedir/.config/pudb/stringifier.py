from collections.abc import Sized


def mock_default_stringifier(value):
    """
    Simpler version of default stringifier
    Reference: https://github.com/inducer/pudb/blob/dab821fe50/pudb/var_view.py#L399

    TODO Can we use default stringifier?
    https://github.com/inducer/pudb/discussions/520
    """
    BASIC_TYPES = (
        type(None),
        int,
        str,
        float,
        complex,
    )

    if isinstance(value, BASIC_TYPES):
        return repr(value)
    elif isinstance(value, Sized):
        try:
            # Example: numpy arrays with shape == () raise on len()
            obj_len = len(value)
        except TypeError:
            pass
        else:
            return f"{type(value).__name__} ({obj_len})"

    return str(type(value).__name__)


def get_fullname(obj):
    return f"{type(obj).__module__}.{type(obj).__qualname__}"


def pudb_stringifier(obj):
    # TODO Use registry pattern
    if get_fullname(obj) == "torch.Tensor":
        threshold = 6  # Empirical magic number

        if obj.numel() <= threshold:
            return f"<torch.Tensor> Value {obj.tolist()}"

        return f"<torch.Tensor> Shape {list(obj.shape)}"

    return mock_default_stringifier(obj)
