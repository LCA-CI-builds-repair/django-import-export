class ImportExportError(Exception):
    """A generic exception for all others to extend."""
    pass

class FieldError(ImportExportError):
    """Raised when an error occurs related to a field during import or export processes."""
    pass
