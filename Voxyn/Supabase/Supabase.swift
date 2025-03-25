//
//  Supabase.swift
//  SupabaseTester
//
//  Created by Kanishq Mehta on 24/03/25.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://kppuhfwghfcjyhfucwtl.supabase.co")!,
  supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtwcHVoZndnaGZjanloZnVjd3RsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI4NzcxMzUsImV4cCI6MjA1ODQ1MzEzNX0.sCtvUoW8CvRYVcF4zcFt0e0IMn-x_DraLvxb4GUcmsc"
)
