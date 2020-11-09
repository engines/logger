# Engines Logging gem

This is a simple wrapper around the logging gem which injects a `logger` into
any module/class that `include`s it. It works for both class and instance
methods.

The logging gem is extremely powerful (and _very_ widely used) but can be
quite confusing so the aim of this gem is threefold: minimise the noise and
ceremony around setting up logging; ensure sensible defaults and finally allow
it to be configured at runtime.


# Usage

To use this you will need to `require` the gem and then `include Engines::Logger`
in any module/class that requires logging. Then it's just a matter of calling
`logger.<lebel>`, where logger can be any one of the following: `debug`,
`info`, `warn`, `error` & `fatal`


## Example use

class FooBar
  include Engines::Logger

  def forbarian
    logger.debug("What is a foobarian?")
  end
end

That really is all there is to it!


# Configuration

The gem can be configured with the following environment variables (with defaults):

* ENGINES_LOG_APPENDER — stdout
* ENGINES_LOG_APPENDER_FILENAME — <unset>
* ENGINES_LOG_PATTERN — "%d [%2p] %7l - %12c:%-3L - %m\\n"
* ENGINES_LOG_DATE_PATTERN — "%Y/%m/%d %H:%M:%S.%3N"
* ENGINES_LOG_LEVEL — debug
* ENGINES_LOG_TRACE — true

Note: ENGINES_LOG_APPENDER_FILENAME is only used if ENGINES_LOG_APPENDER is set
to file or rollingfile.


## Example Configuration

The easiest thing to do, certainly for development is use direnv and add the
environment to that.


### Development

```bash
# This can take the following values: stderr, stdout, file, rollingfile or syslog
export ENGINES_LOG_APPENDER=stderr

# This is ignored unless ENGINES_LOG_APPENDER is set to file or rollingfile
export ENGINES_LOG_APPENDER_FILENAME=engines.log

# See https://rubydoc.info/gems/logging/Logging/Layouts/Pattern for options
export ENGINES_LOG_PATTERN="%d [%5p] %7l - %12c - %F:%-3L - %m\\n"

# See the documentation for strftime for details
export ENGINES_LOG_DATE_PATTERN="%Y/%m/%d %H:%M:%S.%3N"

# The log levels supported are: debug, info, warn, error, fatal
export ENGINES_LOG_LEVEL=debug

# This is required for F (file name), L (line numbers) & M (method name)
export ENGINES_LOG_TRACE=true
```

## Production

```bash
# This can take the following values: stderr, stdout, file, rollingfile or syslog
export ENGINES_LOG_APPENDER=stdout

# This is ignored unless ENGINES_LOG_APPENDER is set to file or rollingfile
# export ENGINES_LOG_APPENDER_FILENAME=engines.log

# See https://rubydoc.info/gems/logging/Logging/Layouts/Pattern for options
export ENGINES_LOG_PATTERN="%d [%2p] %7l - %12c - %m\\n"

# See the documentation for strftime for details
export ENGINES_LOG_DATE_PATTERN="%Y/%m/%d %H:%M:%S.%3N"

# The log levels supported are: debug, info, warn, error, fatal
export ENGINES_LOG_LEVEL=info

# This is required for F (file name), L (line numbers) & M (method name)
export ENGINES_LOG_TRACE=false
```
