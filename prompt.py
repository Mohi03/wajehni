from flask import Flask, jsonify, request, render_template
from flask_cors import CORS
import google.generativeai as genai
from google.generativeai import types

app = Flask(__name__)
CORS(app, origins="*")


@app.route('/', methods=['GET'])
def home():
    return render_template('index.html')


@app.route('/', methods=['POST'])
def main():
    
    data = request.get_json()
    specialty = data.get("specialty")
    answers = data.get("answers", [])  
        
    try:
        genai.configure(api_key="AIzaSyBzS4ZG8WdpuSIESr4omIJmAC2j_TVmJbo")
            
        if not answers:
            model = genai.GenerativeModel('gemini-2.0-flash')
            response = model.generate_content(
                f"""Write 15 simple and clear yes or no questions in Arabic only. to help a student in Algeria explore suitable university majors.you have make sure that the quetions are only yes/no questions. dont ask if they wnat to work alone or in a team. Do not write anything except the questions directly.
                this is the specialty of colleges use them and based of them and the specialty of secondry school i will give u. based of both informations and stil focus on the specialty of secondry school the most to create meaninfull quetions. i will use the answers of this questions later to choose my future specialty of college
                this is existing colleges specialty and between the parentheses are the secondary school specialty those who are allowed to choose from :
               * ميدان علوم الطبيعة والحياة
   * الشعب: (علوم تجريبية، رياضيات)
 * ميدان علوم الأرض والكون
   * الشعب: (علوم تجريبية، رياضيات)
 * ميدان علوم الفلاحة
   * الشعب: (علوم تجريبية، رياضيات)
 * ميدان علوم البيطرة
   * الشعب: (علوم تجريبية، رياضيات)
 * ميدان علوم المادة
   * الشعب: (علوم وتكنولوجيا، رياضيات)
 * ميدان علوم وتكنولوجيا
   * الشعب: (علوم تجريبية، رياضيات، تقني رياضي)
 * ميدان رياضيات وإعلام آلي
   * الشعب: (رياضيات، علوم تجريبية، تقني رياضي)
 * المدارس الوطنية العليا في الإعلام الآلي
   * الشعب: (رياضيات، علوم تجريبية، تقني رياضي)
 * المدارس الوطنية العليا بالقطب التكنولوجي سيدي عبد الله
   * الشعب: (رياضيات، علوم تجريبية، تقني رياضي)
 * ميدان هندسة معمارية، عمران ومهن المدينة
   * الشعب: (رياضيات، تقني رياضي، علوم تجريبية)
 * ميدان آداب ولغات أجنبية (لغة فرنسية)
   * الشعب: (لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان آداب ولغات أجنبية (لغة إنجليزية)
   * الشعب: (لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان آداب ولغات أجنبية (لغة إسبانية)
   * الشعب: (لغات أجنبية، آداب وفلسفة)
 * ميدان آداب ولغات أجنبية (لغة ألمانية)
   * الشعب: (لغات أجنبية، آداب وفلسفة)
 * ميدان آداب ولغات أجنبية (لغة إيطالية)
   * الشعب: (لغات أجنبية، آداب وفلسفة)
 * ميدان آداب ولغات أجنبية (لغة روسية)
   * الشعب: (لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان آداب ولغات أجنبية (لغة صينية)
   * الشعب: (لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان آداب ولغات أجنبية (لغة عبرية)
   * الشعب: (لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان آداب ولغات أجنبية (ترجمة)
   * الشعب: (لغات أجنبية)
 * ميدان لغة وثقافة أمازيغية
   * الشعب: (آداب وفلسفة، لغات أجنبية)
 * ميدان لغة وآداب عربي
   * الشعب: (آداب وفلسفة، لغات أجنبية)
 * ميدان علوم إنسانية واجتماعية
   * الشعب: (آداب وفلسفة، لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان علوم إنسانية واجتماعية (علوم إسلامية)
   * الشعب: (آداب وفلسفة، لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان حقوق وعلوم سياسية
   * الشعب: (آداب وفلسفة، لغات أجنبية، علوم تجريبية، تسيير واقتصاد، رياضيات)
 * ميدان علوم اقتصادية والتسيير
   * الشعب: (تسيير واقتصاد، رياضيات، آداب وفلسفة)
 * ميدان علوم تجارية
   * الشعب: (تسيير واقتصاد، رياضيات، آداب وفلسفة)
 * ميدان علوم اقتصادية بالمدارس الوطنية العليا
   * الشعب: (تسيير واقتصاد، رياضيات، علوم تجريبية، تقني رياضي)
 * علوم وتقنيات النشاطات البدنية والرياضية
   * الشعب: (كل شعب البكالوريا)
                Specialty: {specialty}"""
            )
            return jsonify({
                'questions': response.text
            })
            

        model = genai.GenerativeModel('gemini-2.0-flash')
        response = model.generate_content(
            f"""Analyze a student's responses to a series of career guidance questions and, based on their input, suggest suitable college major specializations.

Base your suggestions primarily on the student's secondary school specialty and their answers to the questions.

If the student's answers are negative for all questions, or show no interest in any field,try to explain to him suggest joining the military as a suitable option.
Student's secondary school specialty: {specialty}

Input Format for Student Responses:

The student's answers will be provided in a clear, question-and-answer format, where each answer directly follows the question it addresses.

Analysis and Output Instructions:

Based on the student's provided answers, suggest 2-3 specific college major specializations in algeria , make sure that the specializations exist in algeria , align with their stated inclinations. For each suggested major, briefly explain why it's a good fit, directly linking it to the patterns observed in the student's responses.

Focus the justification on:

Favorite subjects and topics: What did they enjoy learning or doing most?

Skills demonstrated: What aptitudes or talents did they reveal (e.g., analytical thinking, creative writing, problem-solving, research)?

Preferred activities/environments: Do they prefer lab work, fieldwork, theoretical study, writing, discussion, hands-on application, etc.?

Career aspirations (if mentioned): What future roles or types of work appeal to them?

Dislikes/Areas to avoid: What did they explicitly state they don't want to pursue?

Consider the nuances in their answers. For instance, if a Science student enjoyed Biology but disliked detailed lab work, suggest majors that are more conceptual or field-based. If a Literature student loved creative writing but disliked literary criticism, emphasize creative arts over academic research.

Provide the suggestions clearly, followed by a concise justification based only on the student's provided answers. If the answers point very strongly in one direction, fewer suggestions are acceptable.
answer with arabic . thr suggestions must be available in algeria colleges make sure to give the suggestions based on what spcialty exist in algeria colleges and this is the colleges specialtys with the secondary specialty who can only choose it in parentheses
* ميدان علوم الطبيعة والحياة
   * الشعب: (علوم تجريبية، رياضيات)
 * ميدان علوم الأرض والكون
   * الشعب: (علوم تجريبية، رياضيات)
 * ميدان علوم الفلاحة
   * الشعب: (علوم تجريبية، رياضيات)
 * ميدان علوم البيطرة
   * الشعب: (علوم تجريبية، رياضيات)
 * ميدان علوم المادة
   * الشعب: (علوم وتكنولوجيا، رياضيات)
 * ميدان علوم وتكنولوجيا
   * الشعب: (علوم تجريبية، رياضيات، تقني رياضي)
 * ميدان رياضيات وإعلام آلي
   * الشعب: (رياضيات، علوم تجريبية، تقني رياضي)
 * المدارس الوطنية العليا في الإعلام الآلي
   * الشعب: (رياضيات، علوم تجريبية، تقني رياضي)
 * المدارس الوطنية العليا بالقطب التكنولوجي سيدي عبد الله
   * الشعب: (رياضيات، علوم تجريبية، تقني رياضي)
 * ميدان هندسة معمارية، عمران ومهن المدينة
   * الشعب: (رياضيات، تقني رياضي، علوم تجريبية)
 * ميدان آداب ولغات أجنبية (لغة فرنسية)
   * الشعب: (لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان آداب ولغات أجنبية (لغة إنجليزية)
   * الشعب: (لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان آداب ولغات أجنبية (لغة إسبانية)
   * الشعب: (لغات أجنبية، آداب وفلسفة)
 * ميدان آداب ولغات أجنبية (لغة ألمانية)
   * الشعب: (لغات أجنبية، آداب وفلسفة)
 * ميدان آداب ولغات أجنبية (لغة إيطالية)
   * الشعب: (لغات أجنبية، آداب وفلسفة)
 * ميدان آداب ولغات أجنبية (لغة روسية)
   * الشعب: (لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان آداب ولغات أجنبية (لغة صينية)
   * الشعب: (لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان آداب ولغات أجنبية (لغة عبرية)
   * الشعب: (لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان آداب ولغات أجنبية (ترجمة)
   * الشعب: (لغات أجنبية)
 * ميدان لغة وثقافة أمازيغية
   * الشعب: (آداب وفلسفة، لغات أجنبية)
 * ميدان لغة وآداب عربي
   * الشعب: (آداب وفلسفة، لغات أجنبية)
 * ميدان علوم إنسانية واجتماعية
   * الشعب: (آداب وفلسفة، لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان علوم إنسانية واجتماعية (علوم إسلامية)
   * الشعب: (آداب وفلسفة، لغات أجنبية، علوم تجريبية، تسيير واقتصاد)
 * ميدان حقوق وعلوم سياسية
   * الشعب: (آداب وفلسفة، لغات أجنبية، علوم تجريبية، تسيير واقتصاد، رياضيات)
 * ميدان علوم اقتصادية والتسيير
   * الشعب: (تسيير واقتصاد، رياضيات، آداب وفلسفة)
 * ميدان علوم تجارية
   * الشعب: (تسيير واقتصاد، رياضيات، آداب وفلسفة)
 * ميدان علوم اقتصادية بالمدارس الوطنية العليا
   * الشعب: (تسيير واقتصاد، رياضيات، علوم تجريبية، تقني رياضي)
 * علوم وتقنيات النشاطات البدنية والرياضية
   * الشعب: (كل شعب البكالوريا)
answer directly dont write anything accept the suggestions dont write why just give the specializations

Student answers: {answers}"""
        )
        return jsonify({
            'suggestions': response.text
        })
        
    except Exception as e:
        print(f"Error: {str(e)}")
        return jsonify({'error': str(e)}), 500
        

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
