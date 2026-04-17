# Use the official Mono image — ships with mono-runtime + libgdiplus pre-installed,
# which avoids building the full dependency chain (cairo, X11, libjpeg, …) from apt.
FROM mono:6.12

# Copy the pre-extracted PAT directory directly — no apt-get or unzip needed.
COPY MONO-PAT-v3.6.0 /pat/MONO-PAT-v3.6.0
RUN chmod -R 755 /pat

# Copy a sample PCSP model (optional — mount your own at runtime).
COPY football_pressure.pcsp /pat/football_pressure.pcsp

# PAT loads Modules/CSP/ relative to its own directory.
WORKDIR /pat/MONO-PAT-v3.6.0

# Tell callers where the executable lives (no Wine needed — native Mono).
# TMPDIR must be set so Mono's Path.GetTempPath() returns a real Linux path.
ENV PAT_PATH=/pat/MONO-PAT-v3.6.0/PAT3.Console.exe \
    TMPDIR=/tmp

CMD ["bash"]
