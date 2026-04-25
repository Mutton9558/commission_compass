@mcp.tool()
def calculate_complexity_score(scope_description: str, category: str, urgency: str = "normal") -> dict:
    """
    Universal complexity calculator for all commission types (Art, Code, Writing, etc.)
    """
    score = 5.0
    risk_factors = []

    word_count = len(scope_description.split())
    if word_count < 20:
        score += 2.0
        risk_factors.append("High Ambiguity: Scope is too short; potential for 'Scope Creep'.")

    if urgency.lower() in ["high", "rush", "immediate"]:
        score += 1.5
        risk_factors.append("Rush Job: High pressure may lead to burnout or quality issues.")

    category_modifiers = {
        "Creative": 1.1,
        "Technical": 1.3,
        "Administrative": 0.8
    }
    
    score *= category_modifiers.get(category, 1.0)
    
    return {
        "complexity_score": round(min(10.0, score), 2),
        "risk_factors": risk_factors or ["Low risk standard project"]
    }

@mcp.tool()
def get_market_benchmark(category: str, specialization: str = "General") -> dict:
    """Returns 2026 market data for various freelance fields."""
    rates = {
        "Creative": {"General": 45.0, "Motion": 85.0, "Illustration": 60.0},
        "Technical": {"General": 85.0, "AI/ML": 180.0, "Web": 75.0},
        "Writing": {"General": 35.0, "Copywriting": 65.0, "Technical Writing": 90.0}
    }
    
    # Get nested data or default
    cat_data = rates.get(category, {"General": 50.0})
    hourly_rate = cat_data.get(specialization, cat_data["General"])
    
    return {
        "average_hourly": hourly_rate,
        "source": "2026 Industry Aggregated Data",
        "trend": "Upward" if hourly_rate > 100 else "Stable"
    }

@mcp.tool()
def estimate_effort_hours(scope_description: str, experience_level: str = "intermediate") -> int:
    """Estimates billable hours based on scope size and experience."""
    words = len(scope_description.split())
    # Simple heuristic: 1 hour per 50 words of scope-complexity
    base_hours = max(2, words // 40)
    
    exp_mod = {"junior": 1.5, "intermediate": 1.0, "senior": 0.7}
    return round(base_hours * exp_mod.get(experience_level, 1.0))