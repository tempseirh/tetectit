import { google } from '@ai-sdk/google';
import { generateObject } from 'ai';
import { z } from 'zod';

if (!process.env.GOOGLE_GENERATIVE_AI_API_KEY) {
  throw new Error('GOOGLE_API_KEY is not set in environment variables');
}

const schema = z.object({
  diseaseName: z.string(),
  confidence: z.number().min(0).max(1),
  symptoms: z.array(z.string()),
  severity: z.enum(['mild', 'moderate', 'severe']),
  treatment: z.object({
    recommendedActions: z.array(z.string()),
    medications: z.array(z.string()),
    precautions: z.array(z.string()),
    veterinaryConsultation: z.boolean(),
  }),
  additionalNotes: z.string().optional(),
});

type Diagnosis = z.infer<typeof schema>;

export async function detectDisease(
  file: Express.Multer.File,
): Promise<Diagnosis | Error> {
  try {
    const result = await generateObject({
      model: google('gemini-1.5-flash'),
      schema,
      messages: [
        {
          role: 'user',
          content: [
            {
              type: 'text',
              text: "Analyze this image and identify any potential skin diseases or conditions in the animal. Please provide detailed information following these guidelines:\n1. Identify the specific skin condition or disease with high confidence\n2. List all visible symptoms and characteristics present in the image\n3. Assess the severity based on visual indicators\n4. Provide relevant treatment recommendations and precautions\n5. Only include information that can be confidently determined from the image\n6. If any aspect cannot be determined with confidence, mark it as 'Unknown'\n7. For confidence scores, provide a value between 0 and 1\n8. Include whether immediate veterinary consultation is recommended based on visible severity. Use Sentence case for all text",
            },
            {
              type: 'file',
              data: file.buffer,
              mimeType: 'image/jpeg',
            },
          ],
        },
      ],
    });

    return result?.object;
  } catch (error) {
    throw new Error(
      `Diagnostic error: ${
        error instanceof Error ? error.message : 'Unknown error'
      }`,
    );
  }
}
