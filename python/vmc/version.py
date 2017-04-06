import logging
import pkg_resources
import warnings

_logger = logging.getLogger(__package__)

try:
    __version__ = pkg_resources.get_distribution(__package__).version
    _logger.info(__name__ + " " + __version__)
except pkg_resources.DistributionNotFound as e:  # pragma: no cover
    warnings.warn("can't get __version__ because %s package isn't installed" % __package__, Warning)
    __version__ = None
