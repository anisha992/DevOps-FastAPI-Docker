# Use an official lightweight Python image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy the FastAPI app files into the container
COPY . .

# Install dependencies
RUN pip install -r requirements.txt

# Expose port 8000 for the FastAPI app
EXPOSE 8000

# Command to run the FastAPI server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
