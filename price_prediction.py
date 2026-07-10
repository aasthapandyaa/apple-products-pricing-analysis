import pandas as pd
import pyodbc

# Connect to SQL Server
conn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=HET-LAPTOP\\SQLEXPRESS;'
    'DATABASE=apple_pricing;'
    'Trusted_Connection=yes;'
)

# Pull the data
query = "SELECT * FROM apple_products"
df = pd.read_sql(query, conn)

print(f"Loaded {len(df)} rows")
print(df.head())

conn.close()



# Feature engineering
df['Date'] = pd.to_datetime(df['Date'])
df['Month'] = df['Date'].dt.month
df['Year'] = df['Date'].dt.year

# Convert categorical columns into numbers the model can understand
df_model = pd.get_dummies(df, columns=['Platform', 'Product_Category', 'Condition', 'Sale_Event'], drop_first=True)

# Select features (inputs) and target (what we're predicting)
feature_cols = [col for col in df_model.columns if col.startswith(('Platform_', 'Product_Category_', 'Condition_', 'Sale_Event_'))]
feature_cols += ['Month', 'Year']

X = df_model[feature_cols]
y = df_model['Discount_Pct']

print(f"\nFeatures being used: {feature_cols}")
print(f"Shape of X: {X.shape}")


from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, r2_score

# Split into training (80%) and testing (20%) sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

print(f"\nTraining set size: {X_train.shape[0]}")
print(f"Testing set size: {X_test.shape[0]}")

# Train the Random Forest model
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

print("\nModel trained successfully!")



# Test how good it is
predictions = model.predict(X_test)
mae = mean_absolute_error(y_test, predictions)
r2 = r2_score(y_test, predictions)

print(f"\nMean Absolute Error: {mae:.2f}")
print(f"R² Score: {r2:.4f}")

# Feature importance - which factors matter most?
importance = pd.DataFrame({
    'Feature': feature_cols,
    'Importance': model.feature_importances_
}).sort_values('Importance', ascending=False)

print("\nFeature Importance (most influential first):")
print(importance)

import joblib
joblib.dump(model, 'apple_pricing_model.pkl')
print("\nModel saved as apple_pricing_model.pkl")

