# app.py
from flask import Flask, request, jsonify
from flask_mail import Mail, Message
from flask_cors import CORS
import random
import string

app = Flask(__name__)
CORS(app)

# Configure Flask-Mail for Gmail
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'your-email@gmail.com'
app.config['MAIL_PASSWORD'] = 'your-gmail-password'  # or App Password if 2FA enabled

mail = Mail(app)

def generate_random_code(length=8):
    """Generate a random alphanumeric code."""
    letters_and_digits = string.ascii_letters + string.digits
    return ''.join(random.choice(letters_and_digits) for i in range(length))

@app.route('/send-code', methods=['POST'])
def send_code():
    if request.is_json:
        data = request.get_json()
        email = data.get('email')

        if not email:
            return jsonify({'error': 'Email is required'}), 400

        code = generate_random_code()

        # Create email
        msg = Message('Your Random Code', sender='your-email@gmail.com', recipients=[email])
        msg.body = f'Your random code is: {code}'

        # Send email
        try:
            mail.send(msg)
            return jsonify({'message': 'Email sent successfully'})
        except Exception as e:
            return jsonify({'error': str(e)}), 500
    else:
        return jsonify({'error': 'Request must be JSON'}), 400

if __name__ == '__main__':
    app.run(debug=True)