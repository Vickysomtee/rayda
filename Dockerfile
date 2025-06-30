
# Builder stage

FROM python:3.11-slim AS builder

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
PYTHONUNBUFFERED=1
    
# Create working directory
WORKDIR /app
    
# Install pip and build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
build-essential \
gcc \
&& rm -rf /var/lib/apt/lists/*
    
# Install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip \
&& pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt
    

# Final stage

FROM python:3.11-slim
    
# Create non-root user
RUN addgroup --system app && adduser --system --ingroup app app
    
# Set working directory
WORKDIR /app
    
# Copy app and dependencies from builder
COPY --from=builder /wheels /wheels
COPY --from=builder /app/requirements.txt .
RUN pip install --no-cache-dir /wheels/*
    
COPY . .
    
# Fix ownership
RUN chown -R app:app /app
    
# Switch to non-root user
USER app
    
# Expose FastAPI port
EXPOSE 8000
    
    # Start the app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
    