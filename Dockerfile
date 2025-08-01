# Use Python 3.10 slim image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY ["Medi_Buddy_Chatbot Backend/requirements.txt", "./"]
RUN pip install --no-cache-dir -r requirements.txt

# Copy backend code
COPY ["Medi_Buddy_Chatbot Backend/", "./"]

# Expose port
EXPOSE 5000

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"] 