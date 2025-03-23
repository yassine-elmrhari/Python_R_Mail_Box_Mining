# 📧 Mining Mail Box  


## Description  
**Mining Mail Box** is a Data Mining and Machine Learning project designed to analyze corporate email communications. The goal is to classify emails as **professional** or **non-professional** based on their content. The project involves:  

1. **Data Preprocessing & Feature Extraction** – Cleaning and structuring email text.  
2. **Machine Learning Model Training & Evaluation** – Building a predictive model for email classification.  
3. **Visualization & Analysis** – Using word clouds and frequency analysis to explore patterns.  


## Dataset  
The dataset consists of emails extracted from an internal company database. You can download the dataset here:  
🔗 **[Emails Dataset](https://query.data.world/s/5gir5ulhxsknbjryo6yjpagwu5sjwt)**  

The dataset is processed as follows:  
- **Email Signature Extraction** – Categorizes emails based on sender identity.  
- **Text Cleaning** – Removes punctuation, stopwords, and special characters.  
- **Feature Engineering** – Extracts word frequencies and builds word vectors.  


## Project Methodology  

### I. **Data Preprocessing & Feature Engineering**  
This phase involves cleaning and structuring email content for meaningful analysis.  

✅ **Steps:**  
- Load and preprocess the dataset using R (`projet datamining.R`).  
- Convert emails into a structured format.  
- Tokenize, stem, and remove unnecessary text elements.  
- Generate **word frequency tables** and **word clouds**.  

### II. **Machine Learning Model Training & Evaluation**  
This phase focuses on training a **Logistic Regression** model to classify emails.  

✅ **Steps:**  
- Train a model using **X_Train** and **Y_Train** datasets.  
- Evaluate performance using accuracy and confusion matrices.  
- Predict email classifications for new data.  

**Algorithms Used:**  
- Logistic Regression (Python `Train.py`)  


## Implementation  

📌 **Technologies & Tools Used:**  
- **R** (for data preprocessing & visualization)  
- **Python (Scikit-learn)** (for training & prediction)  

✅ **Key Processes:**  
1. **Preprocess emails in R (`projet datamining.R`)**  
   - Clean text data.  
   - Generate **word frequency distributions**.  
   - Save structured datasets.  

2. **Train and evaluate ML models in Python (`Train.py`)**  
   - Load training & test data.  
   - Train **Logistic Regression** for classification.  
   - Compute accuracy & generate confusion matrix.  

3. **Predict new email classifications**  
   - Uses trained model to classify professional & non-professional emails.  


## Results  

📊 **Accuracy Achieved:** ~0.9% 

📌 **Observation:**  
- Professional emails contain **business-related vocabulary**.  
- Non-professional emails contain **casual and unrelated terms**.  


## Conclusions  

🔹 **Data Mining & Machine Learning** effectively classify emails.  
🔹 **Feature engineering (word frequency, vectorization)** improves accuracy.  
🔹 **Future Work:**  
   - Implement **Deep Learning (LSTMs)** for improved classification.  
   - Extend dataset with **real-world corporate emails**.  


## Requirements  
- **Python 3.x**  
- **R & RStudio**  
- **NumPy, Pandas, Scikit-learn**  
- **NLTK (Natural Language Toolkit)**  
- **WordCloud, Matplotlib**  


## Installation and Execution  
1. Clone this repository:  
   ```sh
   git clone https://github.com/yourusername/Mining-Mail-Box.git
   cd Mining-Mail-Box
   ```

2. Install dependencies:  
   ```sh
   pip install -r requirements.txt
   ```

3. Run email preprocessing in R:  
   ```sh
   source("projet datamining.R")
   ```

4. Train the Machine Learning Model:  
   ```sh
   python Train.py
   ```


## Author
Yassine Elmrhari



