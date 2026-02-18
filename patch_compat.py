"""
Compatibility patches for huggingface_hub and PyTorch.
Must be imported BEFORE any whisperx, pyannote, or huggingface imports.
"""

import sys


def apply_huggingface_patch():
    """Patch use_auth_token -> token for newer huggingface_hub versions."""
    try:
        import huggingface_hub
        from huggingface_hub import hf_hub_download as _original

        def _patched(*args, **kwargs):
            if 'use_auth_token' in kwargs:
                kwargs['token'] = kwargs.pop('use_auth_token')
            return _original(*args, **kwargs)

        huggingface_hub.hf_hub_download = _patched

        try:
            from huggingface_hub import file_download
            file_download.hf_hub_download = _patched
        except (ImportError, AttributeError):
            pass

        return True
    except Exception as e:
        print(f"Waarschuwing: HuggingFace patch mislukt: {e}", file=sys.stderr)
        return False


def apply_pytorch_patch():
    """Patch torch.load to default weights_only=False for compatibility."""
    try:
        import torch
        _original_load = torch.load

        def _patched_load(*args, **kwargs):
            if kwargs.get('weights_only') is None:
                kwargs['weights_only'] = False
            return _original_load(*args, **kwargs)

        torch.load = _patched_load
        return True
    except Exception as e:
        print(f"Waarschuwing: PyTorch patch mislukt: {e}", file=sys.stderr)
        return False


# Apply immediately on import
apply_huggingface_patch()
apply_pytorch_patch()
