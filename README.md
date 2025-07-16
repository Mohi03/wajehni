# مستشار التخصصات الجامعية (University Major Advisor)

A web application that helps Algerian students choose their university majors based on their high school specialization and personal interests.

## Features

- Interactive questionnaire system
- AI-powered career counseling
- Arabic language support
- Responsive design
- Real-time suggestions

## Setup Instructions

### 1. Install Dependencies

First, activate the virtual environment and install the required packages:

```bash
source venv/bin/activate
pip install -r requirements.txt
```

### 2. Run the Flask Backend

Start the Flask server:

```bash
source venv/bin/activate
python prompt.py
```

The Flask server will run on `http://localhost:5000`

### 3. Run the Frontend

In a separate terminal, start the live server for the frontend:

```bash
python3 -m http.server 8000
```

The frontend will be available at `http://localhost:8000`

## How to Use

1. Open `http://localhost:8000` in your browser
2. Select your high school specialization (علوم or آداب)
3. Answer the AI-generated questions about your interests and preferences
4. Receive personalized university major suggestions

## File Structure

- `index.html` - Main HTML file
- `style.css` - Styling and responsive design
- `script.js` - Frontend JavaScript functionality
- `prompt.py` - Flask backend with AI integration
- `requirements.txt` - Python dependencies

## Technologies Used

- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Backend**: Flask (Python)
- **AI**: Google Generative AI (Gemini)
- **Styling**: Custom CSS with responsive design 