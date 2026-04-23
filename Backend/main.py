# first build docker image: docker build -t backend-commission-compass
# then create container: docker run -it --name backend-cc-container ./[DIRECTORY OF THE PYTHON FILE]

# to run: docker start -ai backend-cc-container
import os
from openai import OpenAI

client = OpenAI(
    api_key="sk-2e5888fcaf9c14d81844a759d42d5ab28cf9c4fdb6bdcdb3",
    base_url="https://api.z.ai/api/paas/v4"
)

#Things Z.AI will utilise to help form a decision
tools = [
    {
        "type": "function",
        "function": {
            "name": "fetch_business_metrics",
            "description": "Fetch current business metrics to evaluate the project's health.",
            "parameters": {
                "type": "object",
                "properties": {
                    "project_id": {"type": "string", "description": "The ID of the project"}
                },
                "required": ["project_id"]
            }
        }
    }
]

def decision_agent(user_query):
    messages = [
        {"role": "system", "content": (
            ""
            "Weigh the pros and cons objectively, and output a final decision alongside the reasoning for it."
        )},
        {"role": "user", "content": user_query}
    ]

    response = client.responses.create(
        model="glm-5.1",
        instructions = messages,
        temperature=0.3, # Low temperature for consistent logic
        tools=tools,
        tool_choice="auto"
    )
    
    message = response.choices[0].message
    
    # Pass 2: Executing tools and making the final decision
    if message.tool_calls:
        messages.append(message)
        for tool_call in message.tool_calls:
            if tool_call.function.name == "fetch_business_metrics":
                args = json.loads(tool_call.function.arguments)
                print(f"Agent called tool: {tool_call.function.name} with args: {args}")
                
                tool_result = fetch_business_metrics(args["project_id"])
                messages.append({
                    "role": "tool",
                    "tool_call_id": tool_call.id,
                    "content": tool_result
                })
        
        print("Agent is finalizing decision...\n")
        final_response = client.chat.completions.create(
            model="glm-5.1",
            messages=messages
        )
        return final_response.choices[0].message.content

    return message.content

# 3. Execute
if __name__ == "__main__":
    query = "Should we allocate more engineering resources to project 'Alpha-7'?" #Placeholder for now, can take input from frontend
    decision = decision_agent(query)
    print("### Final Output ###\n")
    print(decision)
