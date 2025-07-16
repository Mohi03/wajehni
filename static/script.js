document.addEventListener('DOMContentLoaded', () => {
    // Get DOM elements
    const specialtyDropdown = document.getElementById('specialty-dropdown');
    const getQuestionsBtn = document.getElementById('get-questions-btn');
    const specialtyError = document.getElementById('specialty-error');
    const specialtySelection = document.getElementById('specialty-selection');

    const questionsSection = document.getElementById('questions-section');
    const questionsForm = document.getElementById('questions-form');
    const submitAnswersBtn = document.getElementById('submit-answers-btn');
    const answersError = document.getElementById('answers-error');

    const suggestionsSection = document.getElementById('suggestions-section');
    const majorSuggestionsDiv = document.getElementById('major-suggestions');
    const startOverBtn = document.getElementById('start-over-btn');

    const loadingSpinner = document.getElementById('loading-spinner');

    let currentQuestions = []; // To store questions received from the AI

    // --- Event Listeners ---

    getQuestionsBtn.addEventListener('click', async () => {
        const specialty = specialtyDropdown.value;
        if (!specialty) {
            specialtyError.textContent = "الرجاء اختيار تخصص."; // Arabic: Please select a specialization.
            return;
        }
        specialtyError.textContent = "";
        showLoading();

        try {
            // Step 1: Send specialty to your Python backend to get questions
            const response = await fetch('https://wojhati.onrender.com/', { 
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ specialty: specialty }), // Send specialty
            });

            if (!response.ok) {
                throw new Error(`خطأ في الشبكة! الحالة: ${response.status}`); // Arabic: Network error! Status:
            }

            const data = await response.json();
            // Parse the questions from the response text
            const questionsText = data.questions;
            currentQuestions = questionsText.split('\n').filter(q => q.trim() !== '');

            if (currentQuestions && currentQuestions.length > 0) {
                displayQuestions(currentQuestions);
                specialtySelection.style.display = 'none';
                questionsSection.style.display = 'block';
            } else {
                answersError.textContent = "تعذر استرداد الأسئلة. الرجاء المحاولة مرة أخرى."; // Arabic: Could not retrieve questions. Please try again.
            }

        } catch (error) {
            console.error('خطأ في جلب الأسئلة:', error); // Arabic: Error fetching questions:
            answersError.textContent = `فشل تحميل الأسئلة. ${error.message}`; // Arabic: Failed to load questions.
        } finally {
            hideLoading();
        }
    });

    submitAnswersBtn.addEventListener('click', async () => {
        answersError.textContent = "";
        const studentAnswers = collectAnswers();

        // Basic validation: Check if all answers are filled
        const allAnswered = studentAnswers.every(item => item.answer.trim() !== "");
        if (!allAnswered) {
            answersError.textContent = "الرجاء الإجابة على جميع الأسئلة قبل الإرسال."; // Arabic: Please answer all questions before submitting.
            return;
        }

        showLoading();

        try {
            // Step 2: Send questions and answers to your Python backend
            const response = await fetch('https://wojhati.onrender.com/', { 
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ answers: studentAnswers }), // Send answers
            });

            if (!response.ok) {
                throw new Error(`خطأ في الشبكة! الحالة: ${response.status}`); // Arabic: Network error! Status:
            }

            const data = await response.json();
            // Parse the suggestions from the response text
            const suggestionsText = data.suggestions;
            
            // Display the raw suggestions text for now
            displaySuggestionsText(suggestionsText);
            questionsSection.style.display = 'none';
            suggestionsSection.style.display = 'block';

        } catch (error) {
            console.error('خطأ في جلب الاقتراحات:', error); // Arabic: Error fetching suggestions:
            majorSuggestionsDiv.innerHTML = `<p class="error-message">فشل الحصول على الاقتراحات. ${error.message}</p>`; // Arabic: Failed to get suggestions.
        } finally {
            hideLoading();
        }
    });

    startOverBtn.addEventListener('click', () => {
        // Reset the UI
        specialtySelection.style.display = 'block';
        questionsSection.style.display = 'none';
        suggestionsSection.style.display = 'none';

        specialtyDropdown.value = "";
        questionsForm.innerHTML = ""; // Clear previous questions
        majorSuggestionsDiv.innerHTML = ""; // Clear previous suggestions
        currentQuestions = []; // Reset stored questions
        specialtyError.textContent = "";
        answersError.textContent = "";
    });

    // --- Helper Functions ---

    function displayQuestions(questions) {
        questionsForm.innerHTML = ''; // Clear previous questions
        questions.forEach((qText, index) => {
            const questionGroup = document.createElement('div');
            questionGroup.classList.add('question-group');

            const label = document.createElement('label');
            label.setAttribute('for', `answer-${index}`);
            label.textContent = qText; // Display question text without numbering

            const textarea = document.createElement('textarea');
            textarea.id = `answer-${index}`;
            textarea.name = `answer-${index}`;
            textarea.rows = 4;
            textarea.placeholder = "إجابتك هنا..."; // Arabic: Your answer here...
            textarea.setAttribute('data-question', qText); // Store original question text

            questionGroup.appendChild(label);
            questionGroup.appendChild(textarea);
            questionsForm.appendChild(questionGroup);
        });
    }

    function collectAnswers() {
        const qaPairs = [];
        const textareas = questionsForm.querySelectorAll('textarea');
        textareas.forEach(textarea => {
            qaPairs.push({
                question: textarea.getAttribute('data-question'),
                answer: textarea.value
            });
        });
        return qaPairs;
    }

    function displaySuggestionsText(suggestionsText) {
        majorSuggestionsDiv.innerHTML = '';
        if (!suggestionsText || suggestionsText.trim() === '') {
            majorSuggestionsDiv.innerHTML = "<p>لم يتم العثور على اقتراحات تخصصات محددة بناءً على إجاباتك. الرجاء مراجعة ردودك أو المحاولة مرة أخرى.</p>"; // Arabic: No specific major suggestions could be generated based on your answers.
            return;
        }
        
        // Display the suggestions as formatted text
        const suggestionItem = document.createElement('div');
        suggestionItem.classList.add('suggestion-item');
        
        const suggestionContent = document.createElement('div');
        suggestionContent.innerHTML = suggestionsText.replace(/\n/g, '<br>');
        
        suggestionItem.appendChild(suggestionContent);
        majorSuggestionsDiv.appendChild(suggestionItem);
    }

    function showLoading() {
        loadingSpinner.style.display = 'block';
        // Disable buttons to prevent multiple clicks
        getQuestionsBtn.disabled = true;
        submitAnswersBtn.disabled = true;
    }

    function hideLoading() {
        loadingSpinner.style.display = 'none';
        // Re-enable buttons
        getQuestionsBtn.disabled = false;
        submitAnswersBtn.disabled = false;
    }
}); 
