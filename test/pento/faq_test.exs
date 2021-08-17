defmodule Pento.FAQTest do
  use Pento.DataCase

  alias Pento.FAQ

  describe "questions" do
    alias Pento.FAQ.Question

    @valid_attrs %{answer: "some answer", question: "some question", vote_count: 42}
    @update_attrs %{answer: "some updated answer", question: "some updated question", vote_count: 43}
    @invalid_attrs %{answer: nil, question: nil, vote_count: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FAQ.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert FAQ.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert FAQ.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = FAQ.create_question(@valid_attrs)
      assert question.answer == "some answer"
      assert question.question == "some question"
      assert question.vote_count == 42
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FAQ.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, %Question{} = question} = FAQ.update_question(question, @update_attrs)
      assert question.answer == "some updated answer"
      assert question.question == "some updated question"
      assert question.vote_count == 43
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = FAQ.update_question(question, @invalid_attrs)
      assert question == FAQ.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = FAQ.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> FAQ.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = FAQ.change_question(question)
    end
  end
end
